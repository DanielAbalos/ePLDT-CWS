package model;

public class ProfitAndLossSummaryBean {
	
	double revenues = 0.00;
	double TCVrecurring = 0.00;
	double TCVnonRecurring = 0.00;
	double recurring = 0.00;
	double nonRecurring = 0.00;
	
	double costOfManagedITservices = 0.00;
	double costOfDataCenter = 0.00;
	double costOfCloud = 0.00;
	double costOfCyberSecurity = 0.00;
	
	public double getRevenues() {
		return revenues;
	}
	public void setRevenues(double revenues) {
		this.revenues = revenues;
	}
	public double getTCVrecurring() {
		return TCVrecurring;
	}
	public void setTCVrecurring(double tCVrecurring) {
		TCVrecurring = tCVrecurring;
	}
	public double getTCVnonRecurring() {
		return TCVnonRecurring;
	}
	public void setTCVnonRecurring(double tCVnonRecurring) {
		TCVnonRecurring = tCVnonRecurring;
	}
	public double getRecurring() {
		return recurring;
	}
	public void setRecurring(double recurring) {
		this.recurring = recurring;
	}
	public double getNonRecurring() {
		return nonRecurring;
	}
	public void setNonRecurring(double nonRecurring) {
		this.nonRecurring = nonRecurring;
	}
	public double getCostOfManagedITservices() {
		return costOfManagedITservices;
	}
	public void setCostOfManagedITservices(double costOfManagedITservices) {
		this.costOfManagedITservices = costOfManagedITservices;
	}
	public double getCostOfDataCenter() {
		return costOfDataCenter;
	}
	public void setCostOfDataCenter(double costOfDataCenter) {
		this.costOfDataCenter = costOfDataCenter;
	}
	public double getCostOfCloud() {
		return costOfCloud;
	}
	public void setCostOfCloud(double costOfCloud) {
		this.costOfCloud = costOfCloud;
	}
	public double getCostOfCyberSecurity() {
		return costOfCyberSecurity;
	}
	public void setCostOfCyberSecurity(double costOfCyberSecurity) {
		this.costOfCyberSecurity = costOfCyberSecurity;
	}

}
