#REPORT_LIST={
#'Interest Rate Risk (EVE)' => 'cbxRptTpl_140',
#'Key Rate Duration' => 'cbxRptTpl_180',
#'Expected Monthly NII Analysis' => 'cbxRptTpl_320',
#'Expected Gap Analysis' => 'Expected Gap Analysis',
#'Real Cash Flow' => 'cbxRptTpl_33_10',
#'Two Cycles Comparison' => 'cbxRptTpl_1060',
#'Assumption Report' => 'cbxRptTpl_1070'
#}

ROOT_DIRECTORY = Dir.pwd
DEFAULT_DOWNLOAD_DIRECTORY = "#{ROOT_DIRECTORY}/lib/temp_download_directory/"
GENERATE_REPORT_PATH = "#{ROOT_DIRECTORY}/lib/report/generate_report/"
BENCHMARK_REPORT_PATH = "#{ROOT_DIRECTORY}/lib/report/benchmark_report/"
RESULT_REPORT_PATH = "#{ROOT_DIRECTORY}/lib/test_result/"
CURRENT_DAY = Time.now.strftime("%Y%m%d")
SAVE_TIME = Time.now.strftime("%y%m%d_%H%M%S")
SCREENSHOT_PATH = "#{ROOT_DIRECTORY}/lib/screenshot/" 
#ROOT_DIRECTORY = 'D:/AutoTHCN'
$result_14 = {}

REPORT_LIST = [
  'Interest Rate Risk (EVE)',
  'Key Rate Duration',
  'Expected Monthly NII Analysis',
  'Expected Gap Analysis',
  'Portfolio Analytics',
  'Real Cash Flow',
  'Two Cycles Comparison',
  'Assumption Report', #--this report can not saveas
  'Mortgage Portfolio Analytics',
  'DASHBOARD',
  'ALM DASHBOARD'
]

FRAME_REPORT_LIST = {
  'Interest Rate Risk (EVE)' => 'ReportProgress14',
  'Key Rate Duration' => 'ReportProgress18',
  'Expected Monthly NII Analysis' => 'ReportProgress33',
  'Expected Gap Analysis' => 'ReportProgress29_1',
  'Portfolio Analytics' => 'ReportProgress4',
  'Real Cash Flow' => 'ReportProgress34_1',
  'Two Cycles Comparison' => 'ReportProgress107',
  'Assumption Report' => 'ReportProgress107',
  'Mortgage Portfolio Analytics' => 'ReportProgress96',
  'DASHBOARD' => 'ReportProgress119'
  'ALM DASHBOARD' => 'ReportProgress120'
}

FRAME_REPORT_LIST_ID = [
  'ReportProgress14',
  'ReportProgress18',
  'ReportProgress33',
  'ReportProgress29_1',
  'ReportProgress34_1',
  'ReportProgress107'
  #'ReportProgress107'
]

