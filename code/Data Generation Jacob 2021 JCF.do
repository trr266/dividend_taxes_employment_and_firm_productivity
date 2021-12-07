
/***
June 2021:
-This code starts with the raw data provided by SCB
-At the end of the file, the regression sample is created
***/


/****Generate Information from Personal Income Tax Data for Firm Data***/

global project_path = "SCB_FOLDER"

forvalues x=2000(1)2010{
use "${project_path}\Project_NR__Data\entrp_lisa_`x'.dta" , clear
keep lop_personnr lop_peorgnr
merge n:n lop_personnr using "${project_path}\Project_NR__Data\iot_`x'.dta" 
gen wage = CARB
format %16.0g lop_personnr
rename lop_personnr individual_id
format %16.0g lop_peorgnr
keep wage individual_id lop_peorgnr
duplicates drop
rename lop_peorgnr firm_id
drop if wage==0
egen number_employees=count(individual_id),by(firm_id)
egen sum_wages=sum(wage),by(firm_id)
egen mean_wages=mean(wage),by(firm_id)
egen median_wages=median(wage),by(firm_id)

keep firm_id number_employees sum_wages mean_wages median_wages 
duplicates drop
gen year = `x'

save "${project_path}\Project_NR__Gem\indiv_information_`x'.dta",replace
}

use  "${project_path}\Project_NR__Gem\indiv_information_2000.dta", clear
append using "${project_path}\Project_NR__Gem\indiv_information_2001.dta"
append using "${project_path}\Project_NR__Gem\indiv_information_2002.dta"
append using "${project_path}\Project_NR__Gem\indiv_information_2003.dta"
append using "${project_path}\Project_NR__Gem\indiv_information_2004.dta"
append using "${project_path}\Project_NR__Gem\indiv_information_2005.dta"
append using "${project_path}\Project_NR__Gem\indiv_information_2006.dta"
append using "${project_path}\Project_NR__Gem\indiv_information_2007.dta"
append using "${project_path}\Project_NR__Gem\indiv_information_2008.dta"
append using "${project_path}\Project_NR__Gem\indiv_information_2009.dta"
append using "${project_path}\Project_NR__Gem\indiv_information_2010.dta"

xtset firm_id year

save "${project_path}\Project_NR__Gem\indiv_information_panel.dta", replace

/****Generate Information from Personal Income Tax Data for Firm Data****/




forvalues x=2000(1)2005{
use "${project_path}\Project_NR__Data\k10_`x'", clear

format %16.0g lop_peorgnr
rename lop_peorgnr firm_id

format %16.0g lop_personnr
rename lop_personnr owner_id 

gen year=`x'
gen simple_rule=.
gen general_rule=.

gen div_allow_save_cg_simple=.
gen div_allow_save_cg_general=.

cap gen cash_dividends_simple=V0487
cap gen dividends_as_wage_simple=V0488
cap gen current_div_all_simple=V0917+V0919+V0927+V0944-V0479
cap gen cumm_div_all_simple=V0944
cap gen tot_div_all_simple=V0929
cap gen div_allow_save_simple=V0917+V0919+V0927+V0944-V0479-V0487-V0488
cap replace div_allow_save_simple=0 if div_allow_save_simple<0 
cap gen div_allow_save_cg_simple=.

cap gen cash_dividends_general=V0911
cap gen dividends_as_wage_general=V0481
cap gen current_div_allow_general=V0923+V0924+V0918+V0916
cap gen cumm_div_allow_general=v0496
cap gen tot_div_allow_general=v0482
cap gen div_allow_save_general=V0923+V0924+V0918+V0916-V0911-V0481
cap replace div_allow_save_general=0 if div_allow_save_general<0 
cap gen div_allow_save_cg_general=.


cap gen cash_dividends_simple=0
cap gen dividends_as_wage_simple=0
cap gen current_div_all_simple=0
cap gen cumm_div_all_simple=0
cap gen tot_div_all_simple=0
cap gen div_allow_save_simple=0 

cap gen cash_dividends_general=0
cap gen dividends_as_wage_general=0
cap gen current_div_allow_general=0
cap gen cumm_div_allow_general=0
cap gen tot_div_allow_general=0
cap gen div_allow_save_general=0


gen cost_of_acq_general=.
gen wage_base_allow_general=.
gen firm_payroll=.

gen sale_price=.
gen profit_selling=.
gen loss_selling=.
gen cg_wage_tax=.
gen cg_low_cap_tax=.
gen cg_30_tax=.

keep V0916 V0917 owner_id firm_id simple_rule general_rule cash_dividends_simple dividends_as_wage_simple year  ///
current_div_all_simple cumm_div_all_simple  tot_div_all_simple div_allow_save_simple div_allow_save_cg_simple  ///
cash_dividends_general dividends_as_wage_general current_div_allow_general cumm_div_allow_general  ///
tot_div_allow_general div_allow_save_general  div_allow_save_cg_general cost_of_acq_general wage_base_allow_general firm_payroll sale_price ///
profit_selling loss_selling cg_wage_tax cg_low_cap_tax cg_30_tax


cap drop year
gen year = `x'

save "${project_path}\Project_NR__gem\k10_`x'_translated", replace
}


forvalues x=2006(1)2011{
use "${project_path}\Project_NR__Data\k10_`x'", clear


format %16.0g lop_peorgnr
rename lop_peorgnr firm_id

format %16.0g lop_personnr
rename lop_personnr owner_id 
gen year=2006
gen simple_rule=.
gen general_rule=.
gen cash_dividends_simple=V0413
gen dividends_as_wage_simple=V0415
gen current_div_all_simple=V0410
gen cumm_div_all_simple=V0411
gen tot_div_all_simple=V0412
gen div_allow_save_simple=V0416
gen div_allow_save_cg_simple=V0418

cap gen cash_dividends_general=V0469
cap gen cash_dividends_general=v0469
gen test=cash_dividends_general-cash_dividends_general
gen dividends_as_wage_general=V0471
gen current_div_allow_general=V0431+V0430
gen cumm_div_allow_general=V0432
gen tot_div_allow_general=V0433
gen div_allow_save_general=V0472
gen div_allow_save_cg_general=V0474

gen wage_base_allow_general=V0431
gen firm_payroll=V0434

gen sale_price=V0492
gen profit_selling=V0651
gen loss_selling=V0654
gen cg_wage_tax=V0665
cap gen cg_low_cap_tax=V0690
cap gen cg_low_cap_tax=.
gen cg_30_tax=V0736

gen owner_wage=V0701
gen owner_wage_total=V0702

keep V0468  V0466 V0467 V0410   owner_id firm_id simple_rule general_rule cash_dividends_simple dividends_as_wage_simple year ///
current_div_all_simple cumm_div_all_simple  tot_div_all_simple div_allow_save_simple div_allow_save_cg_simple ///
cash_dividends_general test dividends_as_wage_general current_div_allow_general cumm_div_allow_general ///
tot_div_allow_general div_allow_save_general  div_allow_save_cg_general  wage_base_allow_general firm_payroll sale_price ///
profit_selling loss_selling cg_wage_tax cg_low_cap_tax cg_30_tax owner_wage owner_wage_total 
cap drop year
gen year = `x'

save "${project_path}\Project_NR__gem\k10_`x'_translated", replace
}


use "${project_path}\Project_NR__Data\k10_2012", clear


format %16.0g lop_peorgnr
rename lop_peorgnr firm_id

format %16.0g lop_personnr
rename lop_personnr owner_id 
gen year=2006
gen simple_rule=.
gen general_rule=.
gen cash_dividends_simple=V4504
gen dividends_as_wage_simple=V4505
gen current_div_all_simple=V4722
gen cumm_div_all_simple=V4722
gen tot_div_all_simple=V4722
gen div_allow_save_simple=V4724
gen div_allow_save_cg_simple=V4724

gen cash_dividends_general=V4506
gen test=cash_dividends_general-cash_dividends_general
gen dividends_as_wage_general=V4725
gen current_div_allow_general=1+1
gen cumm_div_allow_general=1
gen tot_div_allow_general=1
gen div_allow_save_general=1
gen div_allow_save_cg_general=1

gen wage_base_allow_general=1
gen firm_payroll=1

gen sale_price=1
gen profit_selling=1
gen loss_selling=1
gen cg_wage_tax=1
cap gen cg_low_cap_tax=1
cap gen cg_low_cap_tax=.
gen cg_30_tax=1

gen owner_wage=V4583
gen owner_wage_total=V4584

keep   owner_id firm_id simple_rule general_rule cash_dividends_simple dividends_as_wage_simple year ///
current_div_all_simple cumm_div_all_simple  tot_div_all_simple div_allow_save_simple div_allow_save_cg_simple ///
cash_dividends_general test dividends_as_wage_general current_div_allow_general cumm_div_allow_general ///
tot_div_allow_general div_allow_save_general  div_allow_save_cg_general  wage_base_allow_general firm_payroll sale_price ///
profit_selling loss_selling cg_wage_tax cg_low_cap_tax cg_30_tax owner_wage owner_wage_total 
cap drop year
gen year = 2012

save "${project_path}\Project_NR__gem\k10_2012_translated", replace


use "${project_path}\Project_NR__Gem\aktiebolag_2000_raw", clear

forvalues x=2001(1)2011{
    keep firm_id year nom_equity
    append using "${project_path}\Project_NR__Gem\aktiebolag_`x'_raw"
}
 keep firm_id year nom_equity
 
 duplicates drop
 
 egen dup = count(y) , by(f y)
 drop if dup ~= 1
 drop dup
save "${project_path}\Project_NR__Gem\info_for_K10", replace

use "${project_path}\Project_NR__gem\k10_2006_translated", clear
append using  "${project_path}\Project_NR__gem\k10_2007_translated",
append using  "${project_path}\Project_NR__gem\k10_2008_translated",
append using  "${project_path}\Project_NR__gem\k10_2009_translated",
append using  "${project_path}\Project_NR__gem\k10_2010_translated",
append using  "${project_path}\Project_NR__gem\k10_2011_translated",
append using  "${project_path}\Project_NR__gem\k10_2012_translated",
append using  "${project_path}\Project_NR__gem\k10_2005_translated",
append using  "${project_path}\Project_NR__gem\k10_2004_translated",
append using  "${project_path}\Project_NR__gem\k10_2003_translated",
append using  "${project_path}\Project_NR__gem\k10_2002_translated",
append using  "${project_path}\Project_NR__gem\k10_2001_translated",
append using  "${project_path}\Project_NR__gem\k10_2000_translated",

cap drop test

compress
 
label var owner_id `"Owner ID"'
label var firm_id `"Firm ID"'
label var year `"Year"'
label var simple_rule `"Simple Rule Applied? (after 2005)"' 
label var general_rule `"General Rule Applied (after 2005)"'
label var cash_dividends_simple `"Total Dividends - Simple/lättnatsbelopp Rule"'
label var dividends_as_wage_simple `"Dividends taxed as Wage - Simple Rule"'
label var current_div_all_simple `"Current Dividend Allowance - Simple Rule"'
label var cumm_div_all_simple `"Dividend Allowance from Past Years - Simple Rule"'
label var tot_div_all_simple `"Total Dividend Allowance - Simple Rule"'
label var div_allow_save_simple `"Unused Dividend Allowance - Simple Rule"'
label var div_allow_save_cg_simple `"Unused Dividend Allowance for Capital Gains - Simple Rule"'
label var cash_dividends_general `"Total Dividends - General Rule"'
label var dividends_as_wage_general `"Dividends taxed as Wage - General Rule"'
label var current_div_allow_general `"Current Dividend Allowance - General Rule"'
label var cumm_div_allow_general `"Dividend Allowance from Past Years - General Rule"'
label var tot_div_allow_general `"Total Dividend Allowance - General Rule"'
label var div_allow_save_general `"Unused Dividend Allowance - General Rule"'
label var div_allow_save_cg_general `"Unused Dividend Allowance for Capital Gains  - General Rule"'
label var cost_of_acq_general `"Costs of Acquisition - General Rule"'
label var wage_base_allow_general `"Wage Base Allowance - General Rule"' 
label var firm_payroll  `"Firm Payroll"'
label var sale_price `"Sale Price"'
label var profit_selling `"Capital Gain from Selling"'
label var loss_selling `"Capital Loss from Selling"'
label var cg_wage_tax `"Capital Gain Taxed as Wage"'
label var cg_low_cap_tax `"Capital Gains taxed at 20%"'
label var cg_30_tax `"Capital Gains taxed at 30%"'




replace simple_rule=1 if  current_div_all_simple>current_div_allow_general & year>2005
replace simple_rule=0 if  current_div_all_simple<current_div_allow_general & year>2005

gen equity_base_allowance=current_div_allow_general-wage_base_allow_general

egen imputed_return_equity=rowmax(V0916 V0917)

egen base_capital=rowtotal(equity_base_allowance  imputed_return_equity)


gen max_simple_allowance=0
replace max_simple_allowance=64950 if year==2006
replace max_simple_allowance=89000 if year==2007
replace max_simple_allowance=91800 if year==2008
replace max_simple_allowance=120000 if year==2009
replace max_simple_allowance=127250 if year==2010
replace max_simple_allowance=127750 if year==2011

gen share_1=V0410/max_simple_allowance

gen buffer=current_div_all_s/(tot_div_all_s-cumm_div_all_s) if share_1>0 & share_1<.
gen test_share=(tot_div_all_s-cumm_div_all_s)/max_simple if buffer>1 &buffer<.

replace share_1 = test_share if test_share~=.

drop buffer test_share

label var share_1 "Ownership Share based on Simple Rule"

cap drop buffer1 buffer2 share_3

egen buffer1=rowmax(V0468 wage_base_allow_general)
egen buffer2=rowmax(V0466 V0467)
gen share_3=buffer1/buffer2

label var share_3 "Ownership Share based on Wage Base"

merge n:1 firm_id year using "${project_path}\Project_NR__Gem\info_for_K10"

drop if _m == 2

drop _m

cap drop buffer1 buffer2
gen share_2=.
replace share_2=imputed_return_equity/nom_equity if year<2006
replace share_2=equity_base_allowance/0.1254/nom_equity if year==2006
replace share_2=equity_base_allowance/0.1254/nom_equity if year==2007
replace share_2=equity_base_allowance/0.1316/nom_equity if year==2008
replace share_2=equity_base_allowance/0.1189/nom_equity if year==2009
replace share_2=equity_base_allowance/0.122/nom_equity if year==2010
replace share_2=equity_base_allowance/0.1184/nom_equity if year==2011


label var share_2 "Ownership Share based on General Rule - Return on Equity"

cap drop share
gen share=.

replace share = share_1 if simple==1 & year>2005
replace share = share_3 if simple==0 & year>2005
replace share = share_2 if year<2006
replace share = share_2 if year>2005 & simple==0 & wage_base_allow_general==0 & V0468==0 & share_1==0

replace share = 1 if share_2>1 & share_2<1.2
replace share=. if share>1
replace share=. if share<0

sum share,d
sum share if year<2006 & share>1,d
sum share if year<2006 ,d
sum share if year>2005,d
label var share "Share in Equity of Active Owner"


egen count_id=count(year), by(firm_id owner_id year)

drop if count_id~=1

drop count_id


egen number_owners_CHC = count(year), by(firm_id year)

count if number_owners_CHC == 1 & share==.

replace share=1 if number_owners_CHC == 1 

egen buf = sum(share) ,by(firm_id year)
gen buf2= share*share/buf

egen HHI=sum(buf2), by(firm_id year)



save "${project_path}\Project_NR__gem\Raw_K10_Panel.dta", replace

/***NOW: Store individual id, then get wage income long with firm id over to the K10 form**/

use  "${project_path}\Project_NR__gem\Raw_K10_Panel.dta", clear

rename owner_id individual_id

keep individual_id year

duplicates drop

save "${project_path}\Project_NR__gem\Owner_IDs.dta", replace

/***NOW: Calculate Wage for the Owner**/

forvalues x=2000(1)2010{
use "${project_path}\Project_NR__Data\entrp_lisa_`x'.dta" , clear

gen wage = LoneInk
format %16.0g lop_personnr
rename lop_personnr individual_id
format %16.0g lop_peorgnr
rename lop_peorgnr firm_id

gen year = `x'

keep individual_id firm_id wage year

merge n:1 individual_id year using "${project_path}\Project_NR__gem\Owner_IDs.dta"

keep if _m == 3

keep individual_id year wage firm_id

save "${project_path}\Project_NR__Gem\owner_wage_info_for_K10_`x'.dta",replace
}

use "${project_path}\Project_NR__Gem\owner_wage_info_for_K10_2000.dta", replace
append using "${project_path}\Project_NR__Gem\owner_wage_info_for_K10_2001.dta"
append using "${project_path}\Project_NR__Gem\owner_wage_info_for_K10_2002.dta"
append using "${project_path}\Project_NR__Gem\owner_wage_info_for_K10_2003.dta"
append using "${project_path}\Project_NR__Gem\owner_wage_info_for_K10_2004.dta"
append using "${project_path}\Project_NR__Gem\owner_wage_info_for_K10_2005.dta"
append using "${project_path}\Project_NR__Gem\owner_wage_info_for_K10_2006.dta"
append using "${project_path}\Project_NR__Gem\owner_wage_info_for_K10_2007.dta"
append using "${project_path}\Project_NR__Gem\owner_wage_info_for_K10_2008.dta"
append using "${project_path}\Project_NR__Gem\owner_wage_info_for_K10_2009.dta"
append using "${project_path}\Project_NR__Gem\owner_wage_info_for_K10_2010.dta"


rename individual_id owner_id
rename firm_id firm_id2
save "${project_path}\Project_NR__Gem\owner_wage_info_for_K10_panel.dta", replace

/***NOW: bring this over to the K10 panel, generate the key variables for the Firm-Level data**/


use  "${project_path}\Project_NR__gem\Raw_K10_Panel.dta", clear

merge n:1 owner_id year using "${project_path}\Project_NR__Gem\owner_wage_info_for_K10_panel.dta"

egen buf_total_owner_wages = sum(wage) if  firm_id==firm_id2, by(firm_id year)
replace buf_total_owner_wages  =0 if buf_total_owner_wages  ==.


egen total_owner_wages = sum(buf_total_owner_wages), by(firm_id year)

keep firm_id year number_owners_CHC  total_owner_wages  HHI
duplicates drop

save "${project_path}\Project_NR__gem\K10_info_for_Firm_Data.dta", replace


/****Generate Raw Firm-Level Data****/











forvalues x=2000(1)2006{
use "${project_path}\Project_NR__Data\aktiebolag_`x'", clear

format %16.0g lop_peorgnr
rename lop_peorgnr firm_id

gen year=`x'
cap gen tax_form=SK_FORM
cap gen tax_form = .
gen jur_form=BJURFORM
gen sector=BSEKTOR
cap gen industry=BSNI92
cap gen industry=BSNI2002
cap gen industry=""
cap replace industry = BSNI2007
gen closelyheld=BFAAB
gen concern=.

gen immaterial_assets=V0234+V0235
gen fixed_assets=V0236+V0237
gen financial_assets=V0230+V0231+V0233+V0202
gen inventory=V0219
gen receivables=V0241+V0207+V0206+V0204+V0205+V0220+V0203
gen cash=V0200
gen totalassets=immaterial_assets+fixed_assets+financial_assets+inventory+receivables+cash

gen nom_equity=V0350+V0351
gen retained_earnings=V0354
gen total_equity=nom_equity+retained_earnings
gen provisions=V0330+V0339+V0320+V0304+V0302
gen pensions=V0320
gen lt_debt=V0329
gen st_debt=V0307+V0301+V0310+V0300+V0319+V0305
gen total_debt=lt_debt+st_debt
gen sh_loan=V0321

gen loss=.
gen lcf=.
gen used_lcf=.

gen advert=V0541
gen corp_tax=SSFVI
gen total_tax=SSLUT

gen turnover=V0400
gen other_income=V0509-V0510+V0402+V0552+V0401
gen laborcosts=V0512+V0514
gen depreciation=V0561+V0560+V0559+V0553-V0554+V0556
gen special_depr=V0590
gen financial_income=V0564+V0565+V0550-V0551+V0566-V0567-V0570+V0571+V0568-V0569
gen fin_inc_group=V0564+V0565
gen financial_income_neg=.
gen operating_profit=V0400+V0401+V0509-V0510+V0402-V0500-V0526-V0528-V0529-V0531-V0536-V0538-V0541-V0530-V0527
/*
turnover+other_income-laborcosts-depreciation-special_depr+financial_income-V0526-V0528-V0529-V0531-V0536-V0538-V0541-V0530-V0511-V0520-V0524-V0527
*/
gen taxable_profit=V58-V70

/**Compare  V58 = taxable profit and V70 = loss for comparison**/


label var firm_id "Firm ID"
label var tax_form "Tax Form"
label var jur_form "Juridisk Form"
label var sector "Sector"
label var industry "Institutional Sector - Industry"
label var closelyheld "Closely Held Firm?"
label var concern "Concern?"
label var immaterial_assets "Immaterial Assets"
label var fixed_assets "Fixed Assets - PPE"
label var financial_assets "Long-Term Financial Assets"
label var inventory "Inventory (short term)"
label var receivables "Accounts receivables"
label var cash "Cash & Equivalents"
label var totalassets "Total Assets"
label var nom_equity "Nominal Capital"
label var retained_earnings "Retained Earnings"
label var total_equity "Total Equity"
label var provisions "Reserves & Provisions"
label var pensions "Pension Provisions"
label var lt_debt "Long_Term Debt"
label var st_debt "Short-Term Debt"
label var total_debt "Total Debt"
label var sh_loan "Shareholder Loan"
label var taxable_profit "Taxable Profit"
label var operating_profit "Operating Profit"
label var loss "Taxable Loss"
label var lcf "Loss Carry Forward (account)"
label var used_lcf "used Loss Carry Forward in t"
label var corp_tax "Corporate Tax"
label var turnover "Turnover"
label var other_income "Other Income"
label var laborcosts "Labor Costs"
label var depreciation "Depreciation"
label var special_depr "Special Depreciations"
label var financial_income "Financial Income"
label var financial_income_neg "Financial Income Neg"
label var fin_inc_group "Financial Income from Group"


save  "${project_path}\Project_NR__Gem\aktiebolag_`x'_raw", replace

}


forvalues x=2007(1)2012{
use "${project_path}\Project_NR__Data\aktiebolag_`x'", clear


format %16.0g lop_peorgnr
rename lop_peorgnr firm_id

gen year=`x'
cap gen tax_form=SK_FORM
cap gen tax_form = .
gen jur_form=BJURFORM
gen sector=BSEKTOR
cap gen industry=BSNI92
cap gen industry=BSNI2002
cap gen industry=""
cap replace industry = BSNI2007
gen closelyheld=BFAAB
gen concern=.

gen immaterial_assets=V7201+V7202
gen fixed_assets=V7214+V7215+V7216+V7217
gen financial_assets=V7230+V7231+V7232+V7233+V7234+V7235
gen inventory=V7241+V7242+V7243+V7244+V7245+V7246
gen receivables=V7251+V7252+V7261+V7262+V7263+V7270+V7271
gen cash=V7281
gen totalassets=immaterial_assets+fixed_assets+financial_assets+inventory+receivables+cash

gen nom_equity=V7301
gen retained_earnings=V7302
gen total_equity=V7301+V7302
gen provisions=V7321+V7322+V7323+V7331+V7332+V7333
gen pensions=V7332
gen lt_debt=V7350+V7351+V7352+V7353+V7354
gen st_debt=V7360+V7361+V7362+V7363+V7364+V7365+V7366+V7367+V7368+V7369+V7370
gen total_debt=lt_debt+st_debt
gen sh_loan=V8026

gen operating_profit=V7410+V7413+V7411-V7510+V7412-V7511-V7512-V7513
cap gen taxable_profit=V58-V70
cap gen taxable_profit=v58-v70

gen loss=.
gen lcf=V7763
gen used_lcf=V7664
gen advert=.
gen corp_tax=SSLUT
gen total_tax=SSLUT
gen turnover=V7410
gen other_income=V7413
gen laborcosts=V7514
gen depreciation=V7515
gen special_depr=V7516
gen financial_income=V7414+V7415+V7416
gen fin_inc_group=V7414+V7415
gen financial_income_neg=V7520+V7519+V7518


label var firm_id "Firm ID"
label var tax_form "Tax Form"
label var jur_form "Juridisk Form"
label var sector "Sector"
label var industry "Institutional Sector - Industry"
label var closelyheld "Closely Held Firm?"
label var concern "Concern?"
label var immaterial_assets "Immaterial Assets"
label var fixed_assets "Fixed Assets - PPE"
label var financial_assets "Long-Term Financial Assets"
label var inventory "Inventory (short term)"
label var receivables "Accounts receivables"
label var cash "Cash & Equivalents"
label var totalassets "Total Assets"
label var nom_equity "Nominal Capital"
label var retained_earnings "Retained Earnings"
label var total_equity "Total Equity"
label var provisions "Reserves & Provisions"
label var pensions "Pension Provisions"
label var lt_debt "Long_Term Debt"
label var st_debt "Short-Term Debt"
label var total_debt "Total Debt"
label var sh_loan "Shareholder Loan"
label var taxable_profit "Taxable Profit"
label var operating_profit "Operating Profit"
label var loss "Taxable Loss"
label var lcf "Loss Carry Forward (account)"
label var used_lcf "used Loss Carry Forward in t"
label var corp_tax "Corporate Tax"
label var turnover "Turnover"
label var other_income "Other Income"
label var laborcosts "Labor Costs"
label var depreciation "Depreciation"
label var special_depr "Special Depreciations"
label var financial_income "Financial Income"
label var financial_income_neg "Financial Income Neg"
label var fin_inc_group "Financial Income from Group"


save  "${project_path}\Project_NR__Gem\aktiebolag_`x'_raw", replace
}





use "${project_path}\Project_NR__Gem\aktiebolag_2000_raw", clear
forvalues x=2001(1)2011{
    append using "${project_path}\Project_NR__Gem\aktiebolag_`x'_raw"
}

drop V0011 V0012 V0044 V0045 V0048 V0049 V0059 V0060 V0069 V0073 V0075 V0077 V0079 V0114 V0115 V0200 V0202 V0203 V0204 V0205 V0206 V0207 V0219 V0220 V0230 V0231 V0233 V0234 V0235 V0236 V0237 V0241 V0299 V0300 V0301 V0302 V0304 V0305 V0307 V0310 V0319 V0320 V0321 V0329 V0330 V0337 V0339 V0340 V0341 V0346 V0347 V0348 V0349 V0350 V0351 V0354 V0399 V0400 V0401 V0402 V0500 V0501 V0509 V0510 V0511 V0512 V0514 V0520 V0524 V0526 V0527 V0528 V0529 V0530 V0531 V0536 V0538 V0541 V0550 V0551 V0552 V0553 V0554 V0556 V0559 V0560 V0561 V0564 V0565 V0566 V0567 V0568 V0569 V0570 V0571 V0578 V0586 V0589 V0590 V0591 V0593 V0594 V0596 V0598 V0599 V0603 V0604 V0605 V0606 V0607 V0608 V0609 V0610 V0617 V0618 V0619 V0620 V0621 V0622 V0623 V0625 V0626 V0629 V0630 V0632 V0633 V0634 V0635 V0636 V0637 V0641 V0652 V0653 V0656 V0657 V0705 V0706 V0707 V0708 V0710 V0711 V0712 V0713 V0720 V0721 V0722 V0724 V0725 V0726 V0740 V0741 V0742 V0744 V0745 V0746 V0747 V0748 V0749 V0750 V0751 V0753 V0756 V0757 V0758 V0759 V0760 V0761 V0762 V0763 V0764 V0765 V0766 V0767 V0768 V0769 V0770 V0771 V0772 V0773 V0774 V0777 V0778 V0781 V0809 V0830 V0832 V0833 V0839 V0840 V0841 V0844 V0846 V0847 V0848 V0849 V0872 V0873 V0889 V0890 V0891 V0892 V0893 V0895 V0954 V0955 V0956 V0957 V0958 V0959 V0960 V0961 V0962 V0963 V0964 V0965



   append using "${project_path}\Project_NR__Gem\aktiebolag_2012_raw", force

   
drop V0011 V0012 V0050 V0342 V0343 V0344 V0345 V0602 V0611 V0612 V0613 V0614 V0615 V0616 V0624 V0896 V0897 V0899 V0998 V0999
 drop V7201 V7202 V7214 V7215 V7216 V7217 V7230 V7231 V7232 V7233 V7234 V7235 V7241 V7242 V7243 V7244 V7245 V7246 V7251 V7252 V7261 V7262 V7263 V7270 V7271 V7281 V7301 V7302 V7321 V7322 V7323 V7331 V7332 V7333 V7343 V7344 V7345 V7346 V7347 V7348 V7349 V7350 V7351 V7352 V7353 V7354 V7360 V7361 V7362 V7363 V7364 V7365 V7366 V7367 V7368 V7369 V7370 V7410 V7411 V7412 V7413 V7414 V7415 V7416 V7417 V7418 V7419 V7420 V7421 V7422 V7450 V7510 V7511 V7512 V7513 V7514 V7515 V7516 V7517 V7518 V7519 V7520 V7521 V7522 V7523 V7524 V7525 V7526 V7527 V7528 V7529 V7550 V7650 V7651 V7652 V7653 V7654 V7655 V7656 V7657 V7658 V7659 V7660 V7661 V7662 V7663 V7664 V7665 V7666 V7667 V7668 V7670 V7750 V7751 V7752 V7753 V7754 V7755 V7756 V7757 V7758 V7759 V7760 V7761 V7762 V7763 V7764 V7765 V7770 V8020 V8021 V8022 V8023 V8024 V8025 V8026 V8027 V8040 V8041 V8044 V8045 VC0899  
   
  drop A46 AAVKAS2 AAVKAST AEAnt AFA02 AFA0375 AFA04 AFA05X AFA075 AFSK02X AFSK04 AFSK04X AFSK1 AFSK1X AHY0 AHY02 AHY025 AHY04 AHY05 AHY06 AHY12 AHYL1 AIND05 AREDBRE AREDBYG AREDMIL AREDSKOG ASLSPA ASLSPAN ASMA0 ASMA05 ASMA075 ASMA1 ASMA10 ASMA15 AVAT AVAT17 AVAT17X AVAT22 AVAT221 AVIN02
  
  
  drop if BMARKPL>0 & BMARKPL<.
  
  drop BLAN BLKFNOV BMARKPL BOBJTYP BPTYP BSCBTB BSEKEL BSEKTOR BSEKV
  drop K10 K10A KUAnt NRVERK NUDSPAR SAVKAST SAVPE SAVUKAP2 SAVUKAP27 SCHEMA SEXPAN SEXPAT SEXPMED SFAST SFASTT SFASTV SFAVG SFORM
  drop SMOMSIN SMOMSUT SREDBRE SREDBYG SREDMIL SREDSKOG SRU SSFVI SSLUT TAXAR TYP_MOMS V7001 V7002 VINDVX VSUM_PFOND advert bkonc05
  drop v58 v70 v7379 vindvx vx2p vx3p vx5n vx5p vx6n vx6p
  drop BAAVK BAAVRU BAFORM BALTEX BANST BASFAST BASFORV BCIV BCREDF BCREDI BDEBTYP BDEKTYP BDUBTAX BENSKS BFAAB BFINFOR BFODAR BFODMAN BFORSAM
  
   
/**Data Adjustments***/

duplicates drop

cap drop multiple
egen multiple=count(firm_id), by(firm_id year)

drop if multiple>1


xtset firm_id year



 cap drop industry 
 gen industry = BSNI2002
 
 cap drop ind_code
 gen ind_code = BSNI2002
 
 replace ind_code = "" if ind_code=="00000"
 
 destring ind_code , replace
 
 replace ind_code=f.ind_code if year == 2002
 replace ind_code=f.ind_code if year == 2001 & ind_code==.
 replace ind_code=f.ind_code if year == 2000 & ind_code==.
 
 forvalues x=1(1)12{
 replace ind_code=f.ind_code if ind_code==.
 replace ind_code=l.ind_code if ind_code==.
 }
 gen sector_code =.
 replace sector_code = 1  if ind_code>0		& ind_code<5000
 replace sector_code = 2  if ind_code>5000  & ind_code<10000
 replace sector_code = 3  if ind_code>10000 & ind_code<15000
 replace sector_code = 4  if ind_code>15000 & ind_code<40000
 replace sector_code = 5  if ind_code>40000 & ind_code<45000
 replace sector_code = 6  if ind_code>45000 & ind_code<50000
 replace sector_code = 7  if ind_code>50000 & ind_code<55000
 replace sector_code = 8  if ind_code>55000 & ind_code<60000
 replace sector_code = 9  if ind_code>60000 & ind_code<65000
 replace sector_code = 10 if ind_code>65000 & ind_code<70000
 replace sector_code = 11 if ind_code>70000 & ind_code<75000
 replace sector_code = 12 if ind_code>75000 & ind_code<80000
 replace sector_code = 13 if ind_code>80000 & ind_code<85000
 replace sector_code = 14 if ind_code>85000 & ind_code<90000
 replace sector_code = 15 if ind_code>90000 & ind_code<96000
 replace sector_code = 16 if ind_code>96000 & ind_code<99000
 
  

gen average_assets=totalassets+l1.totalassets+l2.totalassets

egen indata_3y=count(average_assets),by(firm_id)

drop if indata_3y==0


/***Drop wrong jur_form, sector and firm type companies, e.g. state-owned firms***/

cap drop not_in_dat*
gen not_in_data=1
replace not_in_data=0 if jur_form=="49"
replace not_in_data=1 if jur_form=="10"
replace not_in_data=0 if jur_form==""
replace not_in_data=1 if jur_form=="31"
replace not_in_data=1 if jur_form=="21"
replace not_in_data=1 if jur_form=="22"
replace not_in_data=1 if jur_form=="96"


destring BAGARKAT, replace
gen not_in_data3=1
replace not_in_data3=0  if BAGARKAT==9 | BAGARKAT==42 |BAGARKAT==41  
drop if not_in_data==1
drop if not_in_data3==1

drop not_in_dat*

cap drop data_flaw
gen data_flaw=.
replace data_flaw=1 if sh_loan<0
replace data_flaw=1 if nom_eq<0
replace data_flaw=1 if totalassets<0
replace data_flaw=1 if total_debt<0
replace data_flaw=1 if lt_debt<0
replace data_flaw=1 if st_debt<0
replace data_flaw=1 if turnover<0
replace data_flaw=1 if depreciation<0
replace data_flaw=1 if laborcosts<0
replace data_flaw=1 if provision<0
replace data_flaw=1 if receivables<0
replace data_flaw=1 if inventory<0
replace data_flaw=1 if financial_assets<0
replace data_flaw=1 if fixed_assets<0
replace data_flaw=1 if immaterial_assets<0
replace data_flaw=1 if cash<0
replace data_flaw=1 if  pensions<0
    
replace data_flaw=1 if lcf<0


drop if data_flaw==1
drop  multiple indata_3y  data_flaw

drop  BAGARKAT

drop if BKONC=="K"
drop BSNI92 BINST VX2P VX3P VX4P VX5P VX5N VX6P VX6N V58 V70 BKOMMUN concern BKONC

compress

xtset firm_id year

save   "${project_path}\Project_NR__Gem\raw_firm_panel.dta", replace


use "${project_path}\Project_NR__Gem\raw_firm_panel.dta", clear

 drop if fixed_assets<100000
 drop if totalassets<100000
 
 
 
 
gen sales_assets=turnover/l1.totalassets
gen fa_assets=fixed_assets /totalassets
gen fin_assets=financial_assets /l1.totalassets
gen working_captial=inventory+receivables
gen cash_assets=cash /l1.totalassets
gen profit_assets=taxable_profit/l1.totalassets
gen debt_assets=total_debt/l1.totalassets
gen re_assets=retained_earnings/l1.totalassets
gen sales_growth=ln(turnover/l.turnover)
gen investment=(fixed_assets-l1.fixed_assets+depreciation)/l1.fixed_assets
gen income_assets=operating_profit/l1.totalassets
/*****/



egen min_year=min(year), by(firm_id)
gen buffer_new_firm=(min_year==year & year>2000 & year<.)
gen new_firm=.
replace new_firm=buffer_new_firm
replace new_firm =. if year==2000

drop min_year buffer_new_firm

cap drop _m

merge 1:1 firm_id year using "${project_path}\Project_NR__Gem\indiv_information_panel.dta"

drop if _m==2

cap drop _merge

merge 1:1 firm_id year using "${project_path}\Project_NR__gem\K10_info_for_Firm_Data.dta"


gen CHC = (_m==3)

drop if _m==2

cap drop _merge

xtset firm_id year


replace CHC =1 if year == 2010 & l2.CHC ==1 & l.CHC ==1 & CHC ==0 & f.CHC ==1 & f2.CHC ==1


egen mean_CHC = mean(CHC) , by(firm_id)

gen ln_employees = ln(number_employees)
gen ln_wages =ln(sum_wages/1000-total_owner_wages/1000)

gen ln_nom_equity=ln(nom_equity)

drop  if year>2010

egen sum_CHC = sum(CHC), by(firm_id)


gen mean_cash_4y = (cash_a + l1. cash_a + l2.cash_a + l3.cash_a )/4 if year == 2005

gen mean_re_4y = (re_a + l1.re_a + l2.re_a + l3.re_a )/4 if year == 2005

gen mean_profit_4y = (profit_assets + l1.profit_assets + l2.profit_assets + l3.profit_assets )/4 if year == 2005

cap drop buf_p50 buf_treatment treatment
egen buf_p50 = pctile(mean_cash_4y) if year == 2005&f.CHC==1, p(50)
gen buf_treatment = (mean_cash_4y<=buf_p50) if mean_cash_4y<. & year == 2005 & buf_p50 ~=.&f.CHC==1
egen treatment = mean(buf_treatment), by(firm_id)

reg CHC ln_employees ln_wages treatment if CHC == 1 , cluster(firm_id) nocons
 
*drop if sum_CHC<3
keep if CHC == 1

reg CHC ln_employees ln_wages treatment debt_assets re_assets sales_growth totalassets if CHC == 1 , cluster(firm_id) nocons
 

/**generate industry classifications**/


cap drop year_ind
egen year_ind=group(year sector_code)


gen ln_ta=ln(totalassets)

  cap drop value_added
  gen value_added = taxable_profit+depreciation +sum_wages

  cap drop log_wages
gen log_va=ln(value_added)
gen log_wages=ln(sum_wages)
gen log_fa=ln(fixed_assets)
 
 
 gen tfp_all=. 
  
 gen lp_all=. 
  
 gen cp_all=.
 
 /***More sophisticated measures ***/
 

 
 forvalues x = 1(1)166{
 
 qui{
 cap drop buffer
 cap reg log_va  log_wages log_fa if year_ind == `x' & ln_emp~=. & ln_wages~=.
 cap predict buffer if e(sample), residuals
 cap replace tfp_all=buffer if year_ind == `x' & ln_emp~=. & ln_wages~=.
 
  cap drop buffer
 cap reg log_va log_wages  if year_ind == `x' & ln_emp~=. & ln_wages~=.
 cap predict buffer if e(sample), residuals
 cap replace lp_all=buffer if year_ind == `x' & ln_emp~=. & ln_wages~=.
 
  cap drop buffer
 cap reg log_va log_fa  if year_ind == `x'
 cap predict buffer if e(sample), residuals
 cap replace cp_all=buffer if year_ind == `x' & ln_emp~=. & ln_wages~=.
 }
 display `x'
 
 }
 
 drop if ln_emp==.
 drop if ln_wages==.
  
 foreach var of varlist tfp_all  lp_all  cp_all  {
 cap drop `var'_w
 winsor `var', gen(`var'_w) p(.01)
 }
 

gen lt_debt_assets= lt_debt/totalassets
drop if lt_debt_assets>1
drop if fa_assets>1


reg CHC ln_employees ln_wages treatment debt_assets re_assets sales_growth totalassets if CHC == 1 , cluster(firm_id) nocons
 

winsor investment, gen(investment_w) p(.01)
winsor sales_growth, gen(sg_w) p(.01)
winsor working_captial, gen(working_captial_assets_w) p(.01)
winsor re_assets, gen(re_assets_w) p(.01)
winsor lt_debt_assets, gen(lt_debt_assets_w) p(.01)
winsor sales_assets, gen(sales_assets_w) p(.01)
winsor income_assets, gen(income_assets_w) p(.01)

 gen d_ln_emp=d.ln_emp
 gen wage_growth = d.ln_wages
 
 winsor wage_growth, gen(wage_growth_w) p(0.01)
 winsor d_ln_emp, gen(d_ln_emp_w) p(0.01)
 
compress
drop if total_equity<0


merge 1:1 firm_id year using "${project_path}\Project_NR__gem\State_info_for_Firm_Data.dta"

drop if _m == 2

drop _m

egen c_i_y=group(state year_ind)

xtset firm_id year



 cap drop d_ln_fa
 gen d_ln_fa=d.log_fa
 winsor  d_ln_fa, gen(d_ln_fa_w) p(0.01)
 
 gen empl_inv = (d_ln_emp_w>0 & investment_w>0) if d_ln_emp_w<. &  investment_w<. 
 gen wage_inv = (wage_growth_w>0 & investment_w>0) if wage_growth_w<. &  investment_w<. 

gen ln_tot_equity=ln(total_equity) 


 cap drop d_ln_nom_equity
 gen d_ln_nom_equity=d.ln_nom_equity
 winsor  d_ln_nom_equity, gen(d_ln_nom_equity_w) p(0.01)
 
 
 cap drop d_ln_tot_equity
 gen d_ln_tot_equity=d.ln_tot_equity
 winsor  d_ln_tot_equity, gen(d_ln_tot_equity_w) p(0.01)

 gen equity_increase = (d.nom_equity>0) if nom_equity<.
 
 gen ln_total_debt = ln(total_debt)
 
 cap drop d_ln_total_debt
 gen d_ln_total_debt=d.ln_total_debt
 winsor  d_ln_total_debt, gen(d_ln_total_debt_w) p(0.01)

 
 gen more_owners = (d.number_owners_CHC>0 ) if d.number_owners_CHC<.

 gen debt_ratio = total_debt/totalassets


drop if tax_form==9 
drop if tax_form ==0
drop if nom_equity==0
gen va_per_employee = ln(value_added/number_employees)
gen va_per_fa = ln(value_added/(fixed_assets))

winsor va_per_employee, gen(va_per_employee_w) p(.01)
winsor va_per_fa, gen(va_per_fa_w) p(.01)

cap drop buf_p50 buf_treatment treatment
egen buf_p50 = pctile(mean_cash_4y) if year == 2005&f.CHC==1, p(50)
gen buf_treatment = (mean_cash_4y<=buf_p50) if mean_cash_4y<. & year == 2005 & buf_p50 ~=.&f.CHC==1
egen treatment = mean(buf_treatment), by(firm_id)

cap drop post
gen post = (year>2005)
cap drop post_treat
gen post_treat=post * treatment


reghdfe d_ln_emp_w c.treatment##c.post sg_w re_assets_w lt_debt_assets_w ln_ta if year>2001 & year<2011 , a(firm_id year_ind) cluster(firm_id)

cap drop intests
 gen intests = e(sample)

 /***IT Measure of Productivity**/

 /***JSH Measure of Productivity**/
 
 egen total_wage = total(sum_wages) if value_added>0 & value_added<., by(year_ind)
 egen total_valueadded = total(value_added) if value_added>0 & value_added<., by(year_ind)
 
 gen wage_by_va=total_wage/total_valueadded
 cap drop ind_va
 egen ind_va=mean(wage_by_va)  ,by(sector_code)
 
  cap drop tfp_jsh*
 gen tfp_jsh = ln(value_added)-ind_va*ln(number_employees)-(1-ind_va)*log_fa
 
 winsor tfp_jsh, gen(tfp_jsh_w) p(0.01)
 winsor tfp_jsh if tfp_jsh>0, gen(tfp_jsh_w_trunc) p(0.01)
 
 gen no_employee = (total_owner_wages==0)
 
save "${project_path}\Project_NR__Gem\firm_panel_for_regression", replace






forvalues x=2000(1)2010{
use "${project_path}\Project_NR__Data\entrp_lisa_`x'.dta" , clear
keep lop_personnr Kommun

drop if Kommun==""

gen year = `x'

save "${project_path}\Project_NR__Gem\state_info_`x'.dta",replace
}

use  "${project_path}\Project_NR__Gem\state_info_2000.dta", clear
append using "${project_path}\Project_NR__Gem\state_info_2001.dta"
append using "${project_path}\Project_NR__Gem\state_info_2002.dta"
append using "${project_path}\Project_NR__Gem\state_info_2003.dta"
append using "${project_path}\Project_NR__Gem\state_info_2004.dta"
append using "${project_path}\Project_NR__Gem\state_info_2005.dta"
append using "${project_path}\Project_NR__Gem\state_info_2006.dta"
append using "${project_path}\Project_NR__Gem\state_info_2007.dta"
append using "${project_path}\Project_NR__Gem\state_info_2008.dta"
append using "${project_path}\Project_NR__Gem\state_info_2009.dta"
append using "${project_path}\Project_NR__Gem\state_info_2010.dta"

format %16.0g lop_personnr
rename lop_personnr individual_id
merge n:1 individual_id year using "${project_path}\Project_NR__gem\Owner_IDs.dta"

keep if _m == 3

gen lan = substr(Kommun,1,2)
destring lan, replace

keep individual_id year lan



save "${project_path}\Project_NR__Gem\owner_state_info_for_K10.dta",replace


use  "${project_path}\Project_NR__gem\Raw_K10_Panel.dta", clear
rename owner_id individual_id
merge n:1 individual_id year using "${project_path}\Project_NR__Gem\owner_state_info_for_K10.dta"

cap drop state
egen state = mode(lan) , by(firm_id year) maxmode

keep firm_id year state 
duplicates drop

save "${project_path}\Project_NR__gem\State_info_for_Firm_Data.dta", replace
