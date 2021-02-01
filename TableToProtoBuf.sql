SELECT
  'syntax = "proto3";' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10) +
  'import "google/protobuf/timestamp.proto";' + CHAR(13) + CHAR(10) +
  'import "Protos/decimal.proto";' + CHAR(13) + CHAR(10) +
  'import "Protos/operationstatus.proto";' + CHAR(13) + CHAR(10) +  CHAR(13) + CHAR(10) +
  '//  rpc Get' + a.name + ' (SingleRequest) returns (' + a.name + 'Response);' + CHAR(13) + CHAR(10) +
  '//  rpc Query' + a.name + ' (QueryRequest) returns (' + a.name + 'Response);' + CHAR(13) + CHAR(10) +
  '//  rpc Create' + a.name + ' (' + a.name + ') returns (CreateResponse);' + CHAR(13) + CHAR(10) +
  '//  rpc Update' + a.name + ' (' + a.name + ') returns (OperationStatus);' + CHAR(13) + CHAR(10) +
  '//  rpc Delete' + a.name + ' (DeleteRequest) returns (OperationStatus);' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10) +
  'message ' + a.name + 'Request {' + CHAR(13) + CHAR(10) +
  '  string id = 1;' + CHAR(13) + CHAR(10) +
  '  repeated string attribute = 2;' + CHAR(13) + CHAR(10) +
  '}' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10) +
  'message ' + a.name + 'Query {' + CHAR(13) + CHAR(10) +
  '  string query = 1;' + CHAR(13) + CHAR(10) +
  '  repeated string attribute = 2;' + CHAR(13) + CHAR(10) +
  '  int32 page_number = 3;' + CHAR(13) + CHAR(10) +
  '  int32 results_per_page = 4;' + CHAR(13) + CHAR(10) +
  '}' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10) +
  'message ' + a.name + 'Response {' + CHAR(13) + CHAR(10) +
  '  repeated ' + a.name + ' results = 1;' + CHAR(13) + CHAR(10) +
  '  int32 page_number = 2;' + CHAR(13) + CHAR(10) +
  '  int32 results_per_page = 3;' + CHAR(13) + CHAR(10) +
  '  int32 total_number_results = 4;' + CHAR(13) + CHAR(10) +
  '}' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10) +
  'message ' + a.name + ' {' + CHAR(13) + CHAR(10) + ' ' +
  STUFF((
    SELECT
      '  ' + 
      CASE
        WHEN c.system_type_id IN (34, 189) THEN 'bytes'
        WHEN c.system_type_id IN (36, 231) THEN 'string'
        WHEN c.system_type_id IN (56) THEN 'int32'
        WHEN c.system_type_id IN (61) THEN 'google.protobuf.Timestamp'
        WHEN c.system_type_id IN (104) THEN 'bool'
        WHEN c.system_type_id IN (106) THEN 'DecimalValue'
        WHEN c.system_type_id IN (127) THEN 'int64'
        WHEN c.system_type_id IN (62) THEN 'float'
        ELSE 'UNKNOWN TYPE: ' + FORMAT(c.system_type_id, '0')
      END + ' ' + LOWER(c.name) + ' = ' + CHAR(13) + CHAR(10)
    FROM sys.columns c
    WHERE
      c.object_id = a.object_id
    ORDER BY
      c.name
    FOR XML PATH(''), TYPE)
  .value('.', 'NVARCHAR(MAX)'), 1, 1, '') + '}'
FROM sys.all_objects a
WHERE
  a.name LIKE 'systemuser'