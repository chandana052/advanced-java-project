package com.model;

import java.sql.Date;

public class Employee {

    private int empNo;
    private String empName;
    private Date doJ;
    private String gender;
    private double bSalary;

    // Default Constructor
    public Employee() {}

    // Parameterized Constructor
    public Employee(int empNo, String empName, Date doJ, String gender, double bSalary) {
        this.empNo   = empNo;
        this.empName = empName;
        this.doJ     = doJ;
        this.gender  = gender;
        this.bSalary = bSalary;
    }

    // Getters and Setters
    public int getEmpNo()               { return empNo;   }
    public void setEmpNo(int empNo)     { this.empNo = empNo; }

    public String getEmpName()                  { return empName;   }
    public void setEmpName(String empName)      { this.empName = empName; }

    public Date getDoJ()                { return doJ;   }
    public void setDoJ(Date doJ)        { this.doJ = doJ; }

    public String getGender()                   { return gender;   }
    public void setGender(String gender)        { this.gender = gender; }

    public double getBSalary()                  { return bSalary;   }
    public void setBSalary(double bSalary)      { this.bSalary = bSalary; }

    @Override
    public String toString() {
        return "Employee [empNo=" + empNo + ", empName=" + empName +
               ", doJ=" + doJ + ", gender=" + gender + ", bSalary=" + bSalary + "]";
    }
}
