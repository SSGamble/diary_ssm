package top.qingrang.exception;

public class SqlRollbackException extends RuntimeException {

	public SqlRollbackException() {
		super();
	}

	public SqlRollbackException(String message) {
		super(message);
	}
}
