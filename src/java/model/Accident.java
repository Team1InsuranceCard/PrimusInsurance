/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author area1
 */
public class Accident {

    private int id;
    private Compensation compensation;
    private Timestamp accidentDate;
    private String title;
    private Timestamp createdDate;
    private String humanDamage;
    private String vehicleDamage;
    private String attatchment;

    public Accident() {
    }

    public Accident(int id, Compensation compensation, Timestamp accidentDate, String title, Timestamp createdDate, String humanDamage, String vehicleDamage, String attatchment) {
        this.id = id;
        this.compensation = compensation;
        this.accidentDate = accidentDate;
        this.title = title;
        this.createdDate = createdDate;
        this.humanDamage = humanDamage;
        this.vehicleDamage = vehicleDamage;
        this.attatchment = attatchment;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Compensation getCompensation() {
        return compensation;
    }

    public void setCompensation(Compensation compensation) {
        this.compensation = compensation;
    }

    public Timestamp getAccidentDate() {
        return accidentDate;
    }

    public void setAccidentDate(Timestamp accidentDate) {
        this.accidentDate = accidentDate;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public String getHumanDamage() {
        return humanDamage;
    }

    public void setHumanDamage(String humanDamage) {
        this.humanDamage = humanDamage;
    }

    public String getVehicleDamage() {
        return vehicleDamage;
    }

    public void setVehicleDamage(String vehicleDamage) {
        this.vehicleDamage = vehicleDamage;
    }

    public String getAttatchment() {
        return attatchment;
    }

    public void setAttatchment(String attatchment) {
        this.attatchment = attatchment;
    }

}
