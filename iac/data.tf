data "aws_s3_bucket" "selected" {
  bucket = "outrobucketnaogerenciadopeloterraform2"
}

#data "aws_glue_catalog_table" "dbdefault" {
  #name          = "tabeladefault"
  #database_name = "default"
#}
