#REPORT_LIST={
#'Interest Rate Risk (EVE)' => 'cbxRptTpl_140',
#'Key Rate Duration' => 'cbxRptTpl_180',
#'Expected Monthly NII Analysis' => 'cbxRptTpl_320',
#'Expected Gap Analysis' => 'Expected Gap Analysis',
#'Real Cash Flow' => 'cbxRptTpl_33_10',
#'Two Cycles Comparison' => 'cbxRptTpl_1060',
#'Assumption Report' => 'cbxRptTpl_1070'
#}

DEFAULT_DOWNLOAD_DIRECTORY = "D:/download_test/"
GENERATE_REPORT_PATH = 'D:/AutoTHCN/lib/report/generate_report/'
BENCHMARK_REPORT_PATH = 'D:/AutoTHCN/lib/report/benchmark_report/'
RESULT_REPORT_PATH = 'D:/AutoTHCN/lib/test_result/'
CURRENT_DAY = Time.now.strftime("%Y%m%d")
SAVE_TIME = Time.now.strftime("%y%m%d_%H%M%S")
ROOT_DIRECTORY = 'D:/AutoTHCN'
$result_14 = {}

REPORT_LIST = [
  'Interest Rate Risk (EVE)',
  'Key Rate Duration',
  'Expected Monthly NII Analysis',
  'Expected Gap Analysis',
  'Real Cash Flow',
  'Two Cycles Comparison',
  'Assumption Report' 
]

FRAME_REPORT_LIST = {
  'Interest Rate Risk (EVE)' => 'ReportProgress14',
  'Key Rate Duration' => 'ReportProgress18',
  'Expected Monthly NII Analysis' => 'ReportProgress32',
  'Expected Gap Analysis' => 'ReportProgress28_1',
  'Real Cash Flow' => 'ReportProgress33_1',
  'Two Cycles Comparison' => 'ReportProgress106',
  'Assumption Report' => 'ReportProgress107'
}

FRAME_REPORT_LIST_ID = [
  'ReportProgress14',
  'ReportProgress18',
  'ReportProgress32',
  'ReportProgress28_1',
  'ReportProgress33_1',
  'ReportProgress106',
  'ReportProgress107'
]

