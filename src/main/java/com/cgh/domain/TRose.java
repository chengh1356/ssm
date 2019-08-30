package com.cgh.domain;

public class TRose {
    private String rid;

    private String rosename;

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid == null ? null : rid.trim();
    }

    public String getRosename() {
        return rosename;
    }

    public void setRosename(String rosename) {
        this.rosename = rosename == null ? null : rosename.trim();
    }
}