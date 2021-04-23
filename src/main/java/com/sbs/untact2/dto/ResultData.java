package com.sbs.untact2.dto;

import java.util.LinkedHashMap;
import java.util.Map;

import com.sbs.untact2.util.Util;

import lombok.Data;

@Data
public class ResultData {
	private String resultCode;
	private String msg;
	private Map<String, Object> body;
	
	public ResultData(String resultCode, String msg, Object... args) {
		this.resultCode = resultCode;
		this.msg = msg;
		this.body = Util.mapOf(args);
	}
	public boolean isSuccess() {
		return resultCode.startsWith("P-");
	}
	public boolean isFail() {
		return resultCode.startsWith("F-");
	}
	
	public ResultData(String resultCode, String msg, String bodyParam1Key, Object bodyParam1Value) {
		this(resultCode, msg, bodyParam1Key, bodyParam1Value, null, null);
	}

	public ResultData(String resultCode, String msg, String bodyParam1Key, Object bodyParam1Value, String bodyParam2Key,
			Object bodyParam2Value) {
		this(resultCode, msg, bodyParam1Key, bodyParam1Value, bodyParam2Key, bodyParam2Value, null, null);
	}

	public ResultData(String resultCode, String msg, String bodyParam1Key, Object bodyParam1Value, String bodyParam2Key,
			Object bodyParam2Value, String bodyParam3Key, Object bodyParam3Value) {
		this(resultCode, msg, bodyParam1Key, bodyParam1Value, bodyParam2Key, bodyParam2Value, bodyParam3Key,
				bodyParam3Value, null, null);
	}

	public ResultData(String resultCode, String msg, String bodyParam1Key, Object bodyParam1Value, String bodyParam2Key,
			Object bodyParam2Value, String bodyParam3Key, Object bodyParam3Value, String bodyParam4Key,
			Object bodyParam4Value) {
		this(resultCode, msg);

		Map<String, Object> body = new LinkedHashMap<>();

		if (bodyParam1Key != null) {
			body.put(bodyParam1Key, bodyParam1Value);
		}

		if (bodyParam2Key != null) {
			body.put(bodyParam2Key, bodyParam2Value);
		}

		if (bodyParam3Key != null) {
			body.put(bodyParam3Key, bodyParam3Value);
		}

		if (bodyParam4Key != null) {
			body.put(bodyParam4Key, bodyParam4Value);
		}

		if (body.isEmpty() == false) {
			this.body = body;
		}
	}
}
