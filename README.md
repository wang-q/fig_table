fig_table
=========

Create figures and tables from excel files. Some scripts only work on Windows.

* Create figures from multiple xlsx files
    * `corel_fig.pl`: Windows only, need Excel 2010 and CorelDRAW X5.

* Convert xlsx to csv
    * `xlsx2csv.pl`: platforms independent, can't evaluate formulas.
    * `xlsx2xls.pl`: Windows only.

* Create tables from multiple xlsx files
    * `xlsx_table.pl`: platforms independent.
    * `excel_table.pl`: Windows only, may miss some cells on large data.

* Collect sheets from multiple xlsx files
    * `collect_xlsx.pl`: platforms independent, loses formats.
    * `collect_excel.pl`: Windows only.

* Create background-separate charts from alignDB/ofg or collect_xlsx files
    * `sep_chart.pl`: platforms independent, need R.
