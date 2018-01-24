package com.qzn.struts.models;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="master")
public class Master implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -509472292534586369L;

	@Id
	@GeneratedValue
	@Column(name="id")
	private int id;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(int beginTime) {
		this.beginTime = beginTime;
	}

	public int getEndTime() {
		return endTime;
	}

	public void setEndTime(int endTime) {
		this.endTime = endTime;
	}

	public int getRadius() {
		return radius;
	}

	public void setRadius(int radius) {
		this.radius = radius;
	}

	@Column(name="begin_time")
	private int beginTime;
	
	@Column(name="end_time")
	private int endTime;
	
	@Column(name="radius")
	private int radius;
}
