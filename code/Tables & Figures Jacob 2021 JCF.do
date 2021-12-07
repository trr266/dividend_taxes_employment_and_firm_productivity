
/***
-In this code, I generate all tables and figures shown in the paper
***/

global project_path = "SCB_FOLDER"


use "${project_path}\Project_NR__Gem\firm_panel_for_regression", clear

 /*****************************/ 
 /************Table 1**********/
 /*****************************/
 
 gen ta_stat=totalassets/1000000
 gen equity_stat=total_equity/1000000
 
 gen va_stat = value_added/1000000
 
 tabstat d_ln_emp_w wage_growth_w tfp_all_w lp_all_w cp_all_w treatment number_employees investment_w d_ln_fa_w sg_w  re_assets_w debt_ratio  ln_ta ta_stat log_va va_stat ln_tot_equity equity_stat number_owners_CHC HHI no_employee if intests==1, col(stat) stat(N mean sd p25 p50 p75)
 
 
 
 /*****************************/ 
 /************Table 2**********/
 /*****************************/
 
 cd  "${project_path}\Project_NR__Gem\" 
 /**All Firms**/
reg d_ln_emp_w c.treatment##c.post if year>2000 & year<2011 & intests==1 ,  cluster(firm_id)
 outreg2 using "Table_2.xls", dec(4) se coefastr bracket replace
 
reghdfe d_ln_emp_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_2.xls", dec(4) se coefastr bracket append
 
 sum number_employees if e(sample) & treatment == 1  & year == 2005
 display 12.24119*14789 
 display 12.24119 *14789 * _b[c.treatment#c.post]
 
 gen small = (number_employees<10&l.number_employees<10)
 
 
/**Smaller Firms**/
reg d_ln_emp_w c.treatment##c.post if year>2000 & year<2011 & intests==1 &number_employees<10&l.number_employees<10  ,  cluster(firm_id)
 outreg2 using "Table_2.xls", dec(4) se coefastr bracket append

reghdfe d_ln_emp_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 &number_employees<10&l.number_employees<10  & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_2.xls", dec(4) se coefastr bracket append

/**Larger Firms**/
reg d_ln_emp_w c.treatment##c.post if year>2000 & year<2011 & intests==1 &small == 0  ,  cluster(firm_id)
 outreg2 using "Table_2.xls", dec(4) se coefastr bracket append

reghdfe d_ln_emp_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 &small == 0 & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_2.xls", dec(4) se coefastr bracket append

 sum number_employees if e(sample) & treatment == 1  & year == 2005
 display 29.309 *5249 * _b[c.treatment#c.post]
  
display 29.309 *5249 


 /*****************************/ 
 /************Table 3**********/
 /*****************************/
    
  
 /**All Firms**/
reg wage_growth_w c.treatment##c.post if year>2000 & year<2011 & intests==1 ,  cluster(firm_id)
 outreg2 using "Table_3.xls", dec(4) se coefastr bracket replace
 
reghdfe wage_growth_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011  & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_3.xls", dec(4) se coefastr bracket append
 
/**Smaller Firms**/
reg wage_growth_w c.treatment##c.post if year>2000 & year<2011 & intests==1 &number_employees<10&l.number_employees<10,  cluster(firm_id)
 outreg2 using "Table_3.xls", dec(4) se coefastr bracket append

reghdfe wage_growth_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 &number_employees<10&l.number_employees<10 & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_3.xls", dec(4) se coefastr bracket append

/**Larger Firms**/
reg wage_growth_w c.treatment##c.post if year>2000 & year<2011 & intests==1 &small == 0,  cluster(firm_id)
 outreg2 using "Table_3.xls", dec(4) se coefastr bracket append

reghdfe wage_growth_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011&small == 0& intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_3.xls", dec(4) se coefastr bracket append

 cap drop ln_avg_wage avg_wage_gr*
gen ln_avg_wage = ln(mean_wages)
gen avg_wage_gr=d.ln_avg_wage
winsor avg_wage_gr, gen(avg_wage_gr_w) p(0.01)


reg avg_wage_gr_w c.treatment##c.post if year>2000 & year<2011 & intests==1 ,  cluster(firm_id)
 outreg2 using "Table_3.xls", dec(4) se coefastr bracket append
 
reghdfe avg_wage_gr_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011  & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_3.xls", dec(4) se coefastr bracket append
 
/**Smaller Firms**/
reg avg_wage_gr_w c.treatment##c.post if year>2000 & year<2011 & intests==1 &number_employees<10&l.number_employees<10,  cluster(firm_id)
 outreg2 using "Table_3.xls", dec(4) se coefastr bracket append

reghdfe avg_wage_gr_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 &number_employees<10&l.number_employees<10 & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_3.xls", dec(4) se coefastr bracket append

/**Larger Firms**/
reg avg_wage_gr_w c.treatment##c.post if year>2000 & year<2011 & intests==1 &small == 0,  cluster(firm_id)
 outreg2 using "Table_3.xls", dec(4) se coefastr bracket append

reghdfe avg_wage_gr_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011&small == 0& intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_3.xls", dec(4) se coefastr bracket append

 /*****************************/ 
 /************Table 4**********/
 /*****************************/
    
  
 /**All Firms**/
reg tfp_all_w c.treatment##c.post if year>2000 & year<2011 & intests==1 ,  cluster(firm_id)
 outreg2 using "Table_4.xls", dec(4) se coefastr bracket replace
 
reghdfe tfp_all_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011  & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_4.xls", dec(4) se coefastr bracket append
 
/**Smaller Firms**/
reg tfp_all_w c.treatment##c.post if year>2000 & year<2011 & intests==1 &number_employees<10&l.number_employees<10,  cluster(firm_id)
 outreg2 using "Table_4.xls", dec(4) se coefastr bracket append

reghdfe tfp_all_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 &number_employees<10&l.number_employees<10 & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_4.xls", dec(4) se coefastr bracket append

/**Larger Firms**/
reg tfp_all_w c.treatment##c.post if year>2000 & year<2011 & intests==1 &small == 0,  cluster(firm_id)
 outreg2 using "Table_4.xls", dec(4) se coefastr bracket append

reghdfe tfp_all_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 &small == 0 & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_4.xls", dec(4) se coefastr bracket append

 /***Columns 7 and 8 are estimated at the end of the code**/
 
 

 /*****************************/ 
 /************Table 5**********/
 /*****************************/
      
 /**All Firms**/
reghdfe lp_all_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta if year>2000 & year<2011  & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_5.xls", dec(4) se coefastr bracket replace
       
 /**All Firms**/
reghdfe cp_all_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_5.xls", dec(4) se coefastr bracket append
 
 
 
 /**The difference is estimated below**/
 
 
 

 /*****************************/ 
 /************Table 6**********/
 /*****************************/


egen std_cash = std(cash_assets)
winsor profit_assets, gen(profit_assets_w) p(0.01)
tab treatment, sum(profit_assets_w)

tab treatment post, sum(profit_assets_w)

reghdfe investment_w treatment sg_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1, a(year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_6.xls", dec(4) se coefastr bracket replace 

reghdfe investment_w c.treatment##c.sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1, a(year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_6.xls", dec(4) se coefastr bracket append

reghdfe f.investment_w treatment sg_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1, a(year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_6.xls", dec(4) se coefastr bracket append

reghdfe f.investment_w c.treatment##c.sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1, a(year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_6.xls", dec(4) se coefastr bracket append



reg profit_assets_w c.treatment##c.post if year>2000 & year<2011 & intests==1 ,  cluster(firm_id)
 outreg2 using "Table_6.xls", dec(4) se coefastr bracket append
 
reghdfe profit_assets_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_6.xls", dec(4) se coefastr bracket append



 /*****************************/ 
 /************Table 7**********/
 /*****************************/

cap drop buf_treatment treatment
cap drop buf_p40 buf_p60
egen buf_p40 = pctile(mean_cash_4y) if year == 2005&f.CHC==1, p(40)
egen buf_p60 = pctile(mean_cash_4y) if year == 2005&f.CHC==1, p(60)
gen buf_treatment = (mean_cash_4y<buf_p40) if mean_cash_4y<. & year == 2005&f.CHC==1
replace buf_treatment=. if mean_cash_4y>=buf_p40 & mean_cash_4y<buf_p60 & year == 2005&f.CHC==1
egen treatment = mean(buf_treatment), by(firm_id)


reghdfe d_ln_emp_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011  & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_A.xls", dec(4) se coefastr bracket replace
 
reghdfe wage_growth_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_A.xls", dec(4) se coefastr bracket append
 
 reghdfe tfp_all_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_A.xls", dec(4) se coefastr bracket append
 
reghdfe lp_all_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011  & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_A.xls", dec(4) se coefastr bracket append
 
reghdfe cp_all_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011  & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_A.xls", dec(4) se coefastr bracket append

 
 
cap drop buf_treatment treatment
cap drop buf_p40 buf_p60
egen buf_p40 = pctile(mean_cash_4y) if year == 2005&f.CHC==1, p(20)
egen buf_p60 = pctile(mean_cash_4y) if year == 2005&f.CHC==1, p(80)
gen buf_treatment = (mean_cash_4y<buf_p40) if mean_cash_4y<. & year == 2005&f.CHC==1
replace buf_treatment=. if mean_cash_4y>=buf_p40 & mean_cash_4y<buf_p60 & year == 2005&f.CHC==1
egen treatment = mean(buf_treatment), by(firm_id)


reghdfe d_ln_emp_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_B.xls", dec(4) se coefastr bracket replace
 
reghdfe wage_growth_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011  & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_B.xls", dec(4) se coefastr bracket append
 
 reghdfe tfp_all_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_B.xls", dec(4) se coefastr bracket append
 
reghdfe lp_all_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011  & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_B.xls", dec(4) se coefastr bracket append
 
reghdfe cp_all_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_B.xls", dec(4) se coefastr bracket append

 
 
 cap drop buf_p50 buf_treatment treatment
egen buf_p50 = pctile(mean_re_4y) if year == 2005&f.CHC==1, p(50)
gen buf_treatment = (mean_re_4y<buf_p50) if mean_re_4y<. & year == 2005&f.CHC==1
egen treatment = mean(buf_treatment), by(firm_id)

reghdfe d_ln_emp_w c.treatment##c.post sg_w  debt_ratio ln_ta HHI no_employee if year>2000 & year<2011  & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_C.xls", dec(4) se coefastr bracket replace
 
reghdfe wage_growth_w c.treatment##c.post sg_w  debt_ratio ln_ta HHI no_employee if year>2000 & year<2011  & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_C.xls", dec(4) se coefastr bracket append
 
 reghdfe tfp_all_w c.treatment##c.post sg_w  debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_C.xls", dec(4) se coefastr bracket append
 
reghdfe lp_all_w c.treatment##c.post sg_w  debt_ratio ln_ta HHI no_employee if year>2000 & year<2011  & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_C.xls", dec(4) se coefastr bracket append
 
reghdfe cp_all_w c.treatment##c.post sg_w  debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_C.xls", dec(4) se coefastr bracket append

  
 cap drop buf_p50 buf_treatment treatment
egen buf_p50 = pctile(mean_profit_4y) if year == 2005&f.CHC==1, p(50)
gen buf_treatment = (mean_profit_4y<buf_p50) if mean_profit_4y<. & year == 2005&f.CHC==1
egen treatment = mean(buf_treatment), by(firm_id)


reghdfe d_ln_emp_w c.treatment##c.post sg_w  debt_ratio ln_ta HHI no_employee if year>2000 & year<2011  & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_D.xls", dec(4) se coefastr bracket replace
 
reghdfe wage_growth_w c.treatment##c.post sg_w  debt_ratio ln_ta HHI no_employee if year>2000 & year<2011  & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_D.xls", dec(4) se coefastr bracket append
 
 reghdfe tfp_all_w c.treatment##c.post sg_w  debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_D.xls", dec(4) se coefastr bracket append
 
reghdfe lp_all_w c.treatment##c.post sg_w  debt_ratio ln_ta HHI no_employee if year>2000 & year<2011  & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_D.xls", dec(4) se coefastr bracket append
 
reghdfe cp_all_w c.treatment##c.post sg_w  debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_D.xls", dec(4) se coefastr bracket append

  
 
 cap drop buf_p50 buf_treatment treatment
egen buf_p50 = pctile(mean_cash_4y) if year == 2005&f.CHC==1, p(50)
gen buf_treatment = (mean_cash_4y<buf_p50) if mean_cash_4y<. & year == 2005&f.CHC==1
egen treatment = mean(buf_treatment), by(firm_id)

reghdfe d_ln_emp_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id c_i_y) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_E.xls", dec(4) se coefastr bracket replace
 
reghdfe wage_growth_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id c_i_y) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_E.xls", dec(4) se coefastr bracket append
 
 reghdfe tfp_all_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id c_i_y) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_E.xls", dec(4) se coefastr bracket append
 
reghdfe lp_all_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id c_i_y) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_E.xls", dec(4) se coefastr bracket append
 
reghdfe cp_all_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id c_i_y) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_E.xls", dec(4) se coefastr bracket append
 

 
 

 gen year_2006=(year==2006)
 gen year_07_08=(year==2007 | year==2008)
 gen year_09_10=(year==2009 | year==2010)
 
 reghdfe d_ln_emp_w c.treatment##c.year_2006 c.treatment##c.year_07_08 c.treatment##c.year_09_10 sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_F.xls", dec(4) se coefastr bracket replace
 
reghdfe wage_growth_w c.treatment##c.year_2006 c.treatment##c.year_07_08 c.treatment##c.year_09_10 sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011  & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_F.xls", dec(4) se coefastr bracket append
 
 reghdfe tfp_all_w c.treatment##c.year_2006 c.treatment##c.year_07_08 c.treatment##c.year_09_10 sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011  & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_F.xls", dec(4) se coefastr bracket append
 
reghdfe lp_all_w c.treatment##c.year_2006 c.treatment##c.year_07_08 c.treatment##c.year_09_10 sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011  & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_F.xls", dec(4) se coefastr bracket append
 
reghdfe cp_all_w c.treatment##c.year_2006 c.treatment##c.year_07_08 c.treatment##c.year_09_10 sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1, a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_7_Panel_F.xls", dec(4) se coefastr bracket append


 
 
 /*****************************/ 
 /************Table 8**********/
 /*****************************/
 

reghdfe d_ln_emp_w c.treatment##c.post sg_w c.re_assets_w##c.post##c.treatment debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_8.xls", dec(4) se coefastr bracket replace
 
reghdfe wage_growth_w c.treatment##c.post sg_w c.re_assets_w##c.post##c.treatment debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_8.xls", dec(4) se coefastr bracket append
 
 egen group_treatment=group(treatment year)
 
reghdfe d_ln_emp_w c.treatment##c.post sg_w c.re_assets_w##c.post##c.treatment debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind group_treatment) cluster(firm_id) keepsingleton
 outreg2 using "Table_8.xls", dec(4) se coefastr bracket append
 
reghdfe wage_growth_w c.treatment##c.post sg_w c.re_assets_w##c.post##c.treatment debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind group_treatment) cluster(firm_id) keepsingleton
 outreg2 using "Table_8.xls", dec(4) se coefastr bracket append
  
 
 
 /*****************************/ 
 /************Table 9**********/
 /*****************************/

 
reghdfe investment_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_9.xls", dec(4) se coefastr bracket replace

reghdfe d_ln_fa_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_9.xls", dec(4) se coefastr bracket append

reghdfe empl_inv c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_9.xls", dec(4) se coefastr bracket append

reghdfe wage_inv c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_9.xls", dec(4) se coefastr bracket append

reghdfe d_ln_tot_equity_w c.treatment##c.post sg_w  debt_ratio ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_9.xls", dec(4) se coefastr bracket append

reghdfe more_owners c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta HHI no_employee if year>2000 & year<2010 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_9.xls", dec(4) se coefastr bracket append

reghdfe d_ln_total_debt_w c.treatment##c.post sg_w re_assets_w  ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_9.xls", dec(4) se coefastr bracket append

reghdfe debt_ratio c.treatment##c.post sg_w re_assets_w  ln_ta HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_9.xls", dec(4) se coefastr bracket append

reghdfe d_ln_emp_w d_ln_fa_w if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_9.xls", dec(4) se coefastr bracket append
 
 

 
 
 
 
 
 /***Calculate some of the statistics discussed in the paper**/
 
 
 
 
 
use "${project_path}\Project_NR__Gem\firm_panel_for_regression", clear
 /***Testing Differences within Table 4, Col 4 vs Col 6**/
 
 gen small = 1 if number_employees<10&l.number_employees<10 

 

 egen FE1=group(firm_id small)
 egen FE2=group(small year_ind)
 
 reghdfe tfp_all_w c.treatment##c.post##c.small c.sg_w##c.small c.re_assets_w##c.small c.debt_ratio##c.small c.ln_ta##c.small c.HHI##c.small c.no_employee##c.small if year>2000 & year<2011 & intests==1, a(FE1 FE2) cluster(firm_id) keepsingleton

  outreg2 using "Table_Difference_Tests.xls", dec(4) se coefastr bracket replace
 
 
 
  /***Testing Differences within Table 5, Col 1 vs Col 2**/
  
use "${project_path}\Project_NR__Gem\firm_panel_for_regression", clear
 
 gen dependent = lp_all_w
 gen measure = 0
 
save "${project_path}\Project_NR__Gem\buffer", replace
 
use "${project_path}\Project_NR__Gem\firm_panel_for_regression", clear

 gen dependent = cp_all_w
 gen measure = 1
 
 append using "${project_path}\Project_NR__Gem\buffer"
 
 egen FE1=group(firm_id measure)
 egen FE2=group(measure year_ind)
 
 xtset FE1 year
 
 reghdfe dependent c.treatment##c.post##c.measure c.sg_w##c.measure c.re_assets_w##c.measure c.debt_ratio##c.measure c.ln_ta##c.measure c.HHI##c.measure c.no_employee##c.measure if year>2000 & year<2011 & intests==1, a(FE1 FE2) cluster(firm_id) keepsingleton
outreg2 using "Table_5.xls", dec(4) se coefastr bracket append


 

 
  
use "${project_path}\Project_NR__Gem\firm_panel_for_regression", clear
 
 

 /**********************************/ 
 /****Figure 1 - Parallel Trends****/
 /**********************************/ 

 gen year_2002=(year==2002)
 gen year_2003=(year==2003)
 gen year_2004=(year==2004)
 gen year_2005=(year==2005)

 reghdfe d_ln_emp_w treatment c.treatment#c.year_2003 c.treatment#c.year_2004 c.treatment#c.year_2005 ln_ta if year>2001 & year<2006 &intests==1 ,  cluster(firm_id)  a( year)
 
 lincom c.treatment#c.year_2003+c.treatment#c.year_2004+c.treatment#c.year_2005
 
 cap drop coef se upper lower
 
 gen coef = _b[c.treatment#c.year_2003] in 1
 gen se = _se[c.treatment#c.year_2003] in 1
 
 replace coef = _b[c.treatment#c.year_2004] in 2
 replace se = _se[c.treatment#c.year_2004] in 2
 
 replace coef = _b[c.treatment#c.year_2005] in 3
 replace se = _se[c.treatment#c.year_2005] in 3
 
 gen upper = coef+1.98*se
 gen lower = coef-1.98*se
 
 cap drop x
 gen x = 2003 in 1
 replace x = 2004 in 2
 replace x = 2005 in 3
 
 
 graph twoway (scatter coef x, symbol(D) mcolor(black) yline(0, lcolor(black)) ylabel(-0.04(.02).04) ytitle("Treatment Coefficient Estimate") xtitle("Year")) ///
 (rcap upper lower x, lcolor(gs8) lwidth(thin) xlabel(2003(1)2005) legend(off) graphregion(color(white)))  
 graph export Figure_1_Panel_A.emf, as(emf) replace
 
 reghdfe wage_growth_w treatment c.treatment#c.year_2003 c.treatment#c.year_2004 c.treatment#c.year_2005 ln_ta if year>2001 & year<2006 &intests==1  ,  cluster(firm_id)  a( year)
 
 
 lincom c.treatment#c.year_2003+c.treatment#c.year_2004+c.treatment#c.year_2005
  cap drop coef se upper lower
 
 gen coef = _b[c.treatment#c.year_2003] in 1
 gen se = _se[c.treatment#c.year_2003] in 1
 
 replace coef = _b[c.treatment#c.year_2004] in 2
 replace se = _se[c.treatment#c.year_2004] in 2
 
 replace coef = _b[c.treatment#c.year_2005] in 3
 replace se = _se[c.treatment#c.year_2005] in 3
 
 gen upper = coef+1.98*se
 gen lower = coef-1.98*se
 
 cap drop x
 gen x = 2003 in 1
 replace x = 2004 in 2
 replace x = 2005 in 3
 
 
 graph twoway (scatter coef x, symbol(D) mcolor(black) yline(0, lcolor(black)) ylabel(-0.04(.02).04) ytitle("Treatment Coefficient Estimate") xtitle("Year")) ///
 (rcap upper lower x, lcolor(gs8) lwidth(thin) xlabel(2003(1)2005) legend(off) graphregion(color(white)))  
 graph export Figure_1_Panel_B.emf, as(emf) replace
 
 reghdfe tfp_all_w treatment c.treatment#c.year_2003 c.treatment#c.year_2004 c.treatment#c.year_2005 ln_ta if year>2001 & year<2006  &intests==1 ,  cluster(year_ind)   a( year)
 
 
 lincom c.treatment#c.year_2003+c.treatment#c.year_2004+c.treatment#c.year_2005
 cap drop coef se upper lower
 
 gen coef = _b[c.treatment#c.year_2003] in 1
 gen se = _se[c.treatment#c.year_2003] in 1
 
 replace coef = _b[c.treatment#c.year_2004] in 2
 replace se = _se[c.treatment#c.year_2004] in 2
 
 replace coef = _b[c.treatment#c.year_2005] in 3
 replace se = _se[c.treatment#c.year_2005] in 3
 
 gen upper = coef+1.98*se
 gen lower = coef-1.98*se
 
 cap drop x
 gen x = 2003 in 1
 replace x = 2004 in 2
 replace x = 2005 in 3
 
 
 graph twoway (scatter coef x, symbol(D) mcolor(black) yline(0, lcolor(black)) ylabel(-0.04(.02).04) ytitle("Treatment Coefficient Estimate") xtitle("Year") ) ///
 (rcap upper lower x, lcolor(gs8) lwidth(thin) xlabel(2003(1)2005) legend(off) graphregion(color(white)))  
 graph export Figure_1_Panel_C.emf, as(emf) replace
 

 /**************************************************************************/ 
 /************Figure 2 - Labor-Capital Relation by Size & Industry**********/
 /**************************************************************************/


xtile size_dec=ln_ta, n(10)


 cap drop coef se upper lower
 
 cap drop x

 
reghdfe d_ln_emp_w d_ln_fa_w if year>2000 & year<2011 & intests==1 & size_dec==1, a(year_ind) cluster(firm_id) keepsingleton
  
 gen coef = _b[c.d_ln_fa_w] in 1
 gen se = _se[c.d_ln_fa_w] in 1
 gen x = 1 in 1

forvalues x=2(1)10{
	
reghdfe d_ln_emp_w d_ln_fa_w if year>2000 & year<2011 & intests==1 & size_dec==`x', a(year_ind) cluster(firm_id) keepsingleton
  
 replace coef = _b[c.d_ln_fa_w] in `x'
 replace se = _se[c.d_ln_fa_w] in `x'
 replace x = `x' in `x'
 
}


 gen upper = coef+1.98*se
 gen lower = coef-1.98*se
 
 graph twoway (scatter coef x, symbol(D) mcolor(black) yline(0, lcolor(black)) ylabel(-0.05(.025).11) ytitle("Coefficient Estimate") xtitle("Size Decile") ) ///
 (rcap upper lower x, lcolor(gs8) lwidth(thin) xlabel(1(1)10) legend(off) graphregion(color(white)))  
 graph export Figure_2_Panel_A.emf, as(emf) replace


 
 cap drop coef se upper lower
 cap drop x
 cap drop obs
 
reghdfe d_ln_emp_w d_ln_fa_w  if sector_code==1, a(year) cluster(firm_id) keepsingleton
  
 gen coef = _b[c.d_ln_fa_w] in 1
 gen se = _se[c.d_ln_fa_w] in 1
 gen x = 1 in 1
 gen obs = e(N) in 1
forvalues x=2(1)15{
	
reghdfe d_ln_emp_w d_ln_fa_w if sector_code==`x', a(year) cluster(firm_id) keepsingleton
  
 replace coef = _b[c.d_ln_fa_w] in `x'
 replace se = _se[c.d_ln_fa_w] in `x'
 replace x = `x' in `x'
 replace obs = e(N) in `x'
 }

 gen upper = coef+1.98*se
 gen lower = coef-1.98*se
 
 graph twoway (scatter coef x if obs>100, symbol(D) mcolor(black) yline(0, lcolor(black)) ylabel(-0.15(.05).25) ytitle("Coefficient Estimate") xtitle("Sector Code") ) ///
 (rcap upper lower x if obs>100, lcolor(gs8) lwidth(thin) xlabel(1(1)15) legend(off) graphregion(color(white)))  
 graph export Figure_2_Panel_B.emf, as(emf) replace

 

 
 
 
/***
-Now, I run the results shown in Table 4, Columns 7 & 8
***/

use  "${project_path}\Project_NR__Gem\firm_panel_for_regression", clear

egen company = group(firm_id)
gen i = fixed_assets-l1.fixed_assets+depreciation

gen y=log(value_added)
replace i=log(i)
gen l=log(number_employees)
gen k=log(l.fixed_assets)

 drop if k==. | y==. | l==.
 drop if i==.

 gen SIC = sector_code
 
xtset company year
order company year SIC y l k i

sum year
return list
scalar last=r(max)

egen year2=max(year), by(firm_id)
 *define exit
gen exit = 0

 replace exit=1 if year==year2& year!=last


 gen i2=i^2
 gen k2=k^2
 gen ik=i*k



order company year SIC y l k i i2 k2 ik
gen ind_year=year*1000+SIC

gen capital=0
gen labor=0

sum year
return list
scalar min=r(min)+1
return list
scalar max=r(max)

 matrix betas=J(2,8,0)

 scalar col=0
 gen TFP=.

 cap drop exit_prob
 cap drop res
 cap drop Q
 cap drop y_al
 
 * expanding window production function estimation
 forvalues q=2002/2010{

 * generate exit probabilities
 if `q'>2001 {
 probit exit i k ik i2 k2 if year <=`q'
 predict exit_prob if year <=`q'
 }
 else {
 gen exit_prob = 0
 }

 * first stage regression, estimate labor coef.
 areg y l k i i2 k2 ik if year <=`q', absorb(ind_year)

 predict res, residuals
 cap ereturn list
 cap matrix betas_1=e(b)
 cap scalar col=col+1
 cap matrix betas[1,col]=betas_1[1,1]
 cap replace labor=betas_1[1,1] if year==`q'

 * second stage regression to estimate the coef. for capital
 gen Q= _b[i]*i + _b[k]*k + _b[i2]*i2 + _b[k2]*k2 + _b[ik]*ik
 gen y_al= Q + res 
 
 *nl (y_al = {b_0=0} + {b_1=0.3}*k + {b_2=0.5}*(L.Q ‐ {b_1=0.3}*L.k)+{b_exit=0}*L.exit_prob) if year <=2003 & !missing(L.k) & !missing(L.exit_prob)

 ereturn list
 cap matrix betas_2=e(b)
 cap matrix betas[2,col]=betas_2[1,2]
 cap replace capital=betas_2[1,2] if year==`q'

 * compute TFP
 
 gen buf_`q' =y_al -capital*k
 drop res Q exit_prob y_al
 }

  forvalues q=2002/2010{
 replace TFP = buf_`q' if TFP == .
 }
 
 
 winsor TFP, gen(TFP_w) p(0.01)
 
 cd  "${project_path}\Project_NR__Gem\" 
  reghdfe TFP_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta  HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_4_Col_7_8.xls", dec(4) se coefastr bracket replace
 
 use  "${project_path}\Project_NR__Gem\firm_panel_for_regression", clear

 
  reghdfe tfp_jsh_w c.treatment##c.post sg_w re_assets_w debt_ratio ln_ta  HHI no_employee if year>2000 & year<2011 & intests==1 , a(firm_id year_ind) cluster(firm_id) keepsingleton
 outreg2 using "Table_4_Col_7_8.xls", dec(4) se coefastr bracket append
 
 
 
 
 
 
 