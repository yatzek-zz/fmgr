$.extend( $.fn.dataTableExt.oStdClasses, {
    "sWrapper": "dataTables_wrapper form-inline"
} );

$(document).ready(function() {
  $("#players-table").dataTable({
    "pagingType"      : "full_numbers",
    "bAutoWidth"      : true,
    "aoColumns"       : [null, null, null, {"bSortable": false}, {"bSortable": false}],
    "bServerSide"     : true,
    "sDom"            : "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
    "sPaginationType" : "bootstrap",
    "sAjaxSource"     : "/players.json" }).fnSetFilteringDelay
});
