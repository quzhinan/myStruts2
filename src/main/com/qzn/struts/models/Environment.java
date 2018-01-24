package com.qzn.struts.models;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="mst_environments")
public class Environment implements Serializable {
	
	private static final long serialVersionUID = 31172123012096426L;

	@Id
	@Column(name="id")
	private long id;

	@Column(name="param_key")
	private String key;

	@Column(name="param_name")
	private String name;

	@Column(name="param_value")
	private String value;

	@Column(name="remark")
	private String remark;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}
