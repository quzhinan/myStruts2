package jp.iesolutions.ienursing.actions.ws;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.apache.struts2.json.annotations.JSON;
import org.springframework.beans.factory.annotation.Autowired;

import jp.iesolutions.ienursing.actions.AbstractAction;
import jp.iesolutions.ienursing.services.DeviceService;

@ParentPackage("ies-json-default")
@Results( {
	@Result(
		name = "device", 
		type = "json", 
		params = { "includeProperties", "result,registerResult",
					"excludeProperties",	"nursingList.*\\.documentList," +
						"nursingList.*\\.placeList,"}
	)
})

public class DeviceAction extends AbstractAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8576654764968388262L;
	
	private static final Log log = LogFactory.getLog(DeviceAction.class);
	
	@Autowired
	DeviceService deviceService;
	
	private int registerResult;
	
	private String deviceKey;
		
	private String result;

	private String deviceName;

	@JSON(name="deviceName")
	public String getDeviceName() {
		return deviceName;
	}

	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}

	@JSON(name="result")
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	@JSON(name="registerResult")
	public int getRegisterResult() {
		return registerResult;
	}

	public void setRegisterResult(int registerResult) {
		this.registerResult = registerResult;
	}

	public String getDeviceKey() {
		return deviceKey;
	}

	public void setDeviceKey(String deviceKey) {
		this.deviceKey = deviceKey;
	}

	public String registerDeviceUID() throws Exception {
		log.info(userActionStart(log, "registerDeviceUID","deviceKey",deviceKey,"deviceName",deviceName));
		
		try {
			registerResult = deviceService.registerDeviceUID(deviceKey, deviceName);
			if (registerResult != 0) {
				result = SUCCESS;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.error(e.getStackTrace());
		}
		log.info(userActionEnd(log, "registerDeviceUID", "device","reslut",result));
		return "device";
	}

}
