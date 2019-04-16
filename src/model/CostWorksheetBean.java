package model;

public class CostWorksheetBean {
	
	String planName;
	String productCategory;
	String provider;
	int qty;
	double unitBuyingCosts = 0.00;
	double totalBuyingPrice = 0.00;
	String paymentOptions;
	int contractPeriod;
	double periodAmortized = 0.00;
	double costOfMoney = 0.00;
	double amortizedValue = 0.00;
	double appliedMargin = 0.00;
	double unitSellingPrice = 0.00;
	double totalSellingPrice = 0.00;
	double TCV_recurring = 0.00;
	
	public double getTCV_recurring() {
		return TCV_recurring;
	}
	public void setTCV_recurring(double tCV_recurring) {
		TCV_recurring = tCV_recurring;
	}
	public String getPlanName() {
		return planName;
	}
	public void setPlanName(String planName) {
		this.planName = planName;
	}
	public String getProductCategory() {
		return productCategory;
	}
	public void setProductCategory(String productCategory) {
		this.productCategory = productCategory;
	}
	public String getProvider() {
		return provider;
	}
	public void setProvider(String provider) {
		this.provider = provider;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public double getUnitBuyingCosts() {
		return unitBuyingCosts;
	}
	public void setUnitBuyingCosts(double unitBuyingCosts) {
		this.unitBuyingCosts = unitBuyingCosts;
	}
	public double getTotalBuyingPrice() {
		return totalBuyingPrice;
	}
	public void setTotalBuyingPrice(double totalBuyingPrice) {
		this.totalBuyingPrice = totalBuyingPrice;
	}
	public String getPaymentOptions() {
		return paymentOptions;
	}
	public void setPaymentOptions(String paymentOptions) {
		this.paymentOptions = paymentOptions;
	}
	public int getContractPeriod() {
		return contractPeriod;
	}
	public void setContractPeriod(int contractPeriod) {
		this.contractPeriod = contractPeriod;
	}
	public double getPeriodAmortized() {
		return periodAmortized;
	}
	public void setPeriodAmortized(double periodAmortized) {
		this.periodAmortized = periodAmortized;
	}
	public double getCostOfMoney() {
		return costOfMoney;
	}
	public void setCostOfMoney(double costOfMoney) {
		this.costOfMoney = costOfMoney;
	}
	public double getAmortizedValue() {
		return amortizedValue;
	}
	public void setAmortizedValue(double amortizedValue) {
		this.amortizedValue = amortizedValue;
	}
	public double getAppliedMargin() {
		return appliedMargin;
	}
	public void setAppliedMargin(double appliedMargin) {
		this.appliedMargin = appliedMargin;
	}
	public double getUnitSellingPrice() {
		return unitSellingPrice;
	}
	public void setUnitSellingPrice(double unitSellingPrice) {
		this.unitSellingPrice = unitSellingPrice;
	}
	public double getTotalSellingPrice() {
		return totalSellingPrice;
	}
	public void setTotalSellingPrice(double totalSellingPrice) {
		this.totalSellingPrice = totalSellingPrice;
	}

}
