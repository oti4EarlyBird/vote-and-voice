package com.vvs.platform.controller.admin;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vvs.platform.service.admin.AdminBillsService;

@Controller
@RequestMapping("/admin")
public class BillController {
	
	private final AdminBillsService billService;

    public BillController(AdminBillsService billService) {
        this.billService = billService;
    }
	
	@GetMapping("/bill")
	public String billList() {
		return "admin/adminBillList";
	}
	
	@GetMapping("/import")
    @ResponseBody
    public ResponseEntity<String> importBills(
            @RequestParam(defaultValue = "22") String age,
            @RequestParam(defaultValue = "1")  int pIndex,
            @RequestParam(defaultValue = "1000") int pSize) {

        int count = billService.importBills(age, pIndex, pSize);
        return ResponseEntity.ok("Imported rows: " + count);
    }
}
