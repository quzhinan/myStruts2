package com.qzn.struts.services.exceptions;

import org.apache.commons.logging.Log;

public class CSVInvalidException extends ServiceException {

	private static final long serialVersionUID = -3897356983485947057L;

	public CSVInvalidException() {
	}

	/**
	 * @param message
	 */
	public CSVInvalidException(String message) {
		super(message);
	}
	
	/**
	 * @param message
	 */
	public CSVInvalidException(String message, Log log) {
		super(message);
		log.error("　　　　" + message);
	}

	/**
	 * @param message
	 * @param cause
	 */
	public CSVInvalidException(String message, Throwable cause) {
		super(message, cause);
	}

	/**
	 * @param cause
	 */
	public CSVInvalidException(Throwable cause) {
		super(cause);
	}

}
