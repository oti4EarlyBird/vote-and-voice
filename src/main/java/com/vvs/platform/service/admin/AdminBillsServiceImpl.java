package com.vvs.platform.service.admin;

import com.vvs.platform.dto.admin.AdminBillsDTO;
import com.vvs.platform.dao.admin.AdminBillsDAO;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Parser;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.net.URLEncoder;

import java.nio.charset.StandardCharsets;

import java.time.LocalDate;

import java.util.ArrayList;
import java.util.List;

@Service
public class AdminBillsServiceImpl implements AdminBillsService{
	private final AdminBillsDAO adminBillsDAO;

    @Value("34727d2ddb9e47fea465f68177fe4606")
    private String openKey;

    @Value("https://open.assembly.go.kr/portal/openapi/TVBPMBILL11")
    private String baseUrl;

    public AdminBillsServiceImpl(AdminBillsDAO adminBillsDAO) {
        this.adminBillsDAO = adminBillsDAO;
    }

    @Override
    @Transactional
    public int importBills(String age, int pIndex, int pSize) {
        List<AdminBillsDTO> list = fetchFromOpenApi(age, pIndex, pSize);
        if (list.isEmpty()) return 0;

        // 대량 적재 (INSERT ALL)
        // 너무 많으면 500건 단위로 끊어 넣어도 됨
        int inserted = 0;
        int chunk = 300;
        for (int i = 0; i < list.size(); i += chunk) {
            int to = Math.min(i + chunk, list.size());
            inserted += adminBillsDAO.insertBatch(list.subList(i, to));
        }
        return inserted;
    }

    /** OpenAPI XML -> DTO List + 각 항목의 상세페이지에서 pre#prntSummary 추출 */
    private List<AdminBillsDTO> fetchFromOpenApi(String age, int pIndex, int pSize) {
        try {
            String quotedAge = URLEncoder.encode("'" + age + "'", StandardCharsets.UTF_8.name()); // '22' 형태
            String url = baseUrl
                + "?KEY=" + openKey
                + "&Type=xml"
                + "&pIndex=" + pIndex
                + "&pSize=" + pSize
                + "&AGE=" + quotedAge;

            // 1) XML 파싱
            Document xml = Jsoup.connect(url)
                    .timeout(30_000)
                    .parser(Parser.xmlParser())
                    .get();

            List<AdminBillsDTO> out = new ArrayList<>();
            for (Element row : xml.select("row")) {
            	AdminBillsDTO b = new AdminBillsDTO();

                b.setBillId(text(row, "BILL_ID"));
                b.setAge(text(row, "AGE"));
                b.setBillTitle(text(row, "BILL_NAME"));
                b.setBillNumber(text(row, "BILL_NO"));
                b.setRelatedUrl(text(row, "LINK_URL"));
                b.setCommittee(text(row, "CURR_COMMITTEE"));
                b.setDecisionResult(text(row, "PROC_RESULT_CD")); // 가정
                b.setDecisionDate(parseDate(text(row, "PROC_DT")));

                // 2) 상세 페이지에서 pre#prntSummary 텍스트 추출 → PDF_LINK 컬럼에 저장
                String summary = fetchSummaryFromDetail(b.getRelatedUrl());
                b.setPdfLink(summary);

                out.add(b);
            }
            return out;
        } catch (Exception e) {
            throw new RuntimeException("OpenAPI 호출/파싱 실패", e);
        }
    }

    /** 상세 페이지에서 <pre id="prntSummary">의 내용만 추출 (헤더 문구 제거) */
    private String fetchSummaryFromDetail(String url) {
        if (!StringUtils.hasText(url)) return null;
        try {
            Document doc = Jsoup.connect(url).timeout(30_000).get();
            Element pre = doc.getElementById("prntSummary");
            if (pre == null) return null;

            // 줄바꿈 보존
            String txt = pre.wholeText().trim();

            // "제안이유 및 주요내용" 머리말 제거
            txt = txt.replaceFirst("^\\s*제안이유 및 주요내용\\s*", "").trim();

            // (선택) VARCHAR2(4000) 고려 시 잘라내기
            int max = 3900;
            return (txt.length() > max) ? txt.substring(0, max) : txt;
        } catch (Exception e) {
            // 상세 페이지가 일시 오류여도 전체 작업은 계속
            return null;
        }
    }

    private static String text(Element parent, String tag) {
        Element e = parent.selectFirst(tag);
        return e == null ? null : e.text();
    }

    private static LocalDate parseDate(String s) {
        if (!StringUtils.hasText(s)) return null;
        return LocalDate.parse(s); // API가 YYYY-MM-DD 형태
    }
}
