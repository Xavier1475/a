$(".vistaw").hide();
$(".vista").hide();
$(".ban").hide();
$(".ruc").hide();
$(".nombre").hide();

$(".ruc1").hide();
$(".nombre1").hide();
var id =$("#form_formaPago").val();
if(id==5){
    $(".vistaw").show();
    $(".chtm").addClass("col-lg-6");
    $(".chtm").removeClass("col-lg-4");
}else{
    $(".vistaw").hide();
    $(".chtm").removeClass("col-lg-6");
    $(".chtm").addClass("col-lg-4");
}
if(id==6){
    $(".vista").show();
    $(".chtm").addClass("col-lg-6");
    $(".chtm").removeClass("col-lg-4"); 
}else{
    $(".vista").hide();
    $(".chtm").removeClass("col-lg-6");
    $(".chtm").addClass("col-lg-4");
}
if(id==3 || id==2 || id==4){
    $(".ban").show();
    
}else{
    $(".ban").hide();

}

$(document).on("change","#form_formaPago",function(){
    var id =$(this).val();
    if(id==5){
        $(".vistaw").show();
        $(".chtm").addClass("col-lg-6");
    $(".chtm").removeClass("col-lg-4");
    }else{
        $(".vistaw").hide();
        $(".chtm").removeClass("col-lg-6");
        $(".chtm").addClass("col-lg-4");
    }
    if(id==6){
        $(".vista").show();
        
    }else{
        $(".vista").hide();
        

    }
    if(id==3 || id==2 || id==4){
        $(".ban").show();
        
    }else{
        $(".ban").hide();


    }
});
function saldo(){
total=0
$("input:checkbox:checked").each(function() {
   var count = Number($(this).val());
   total += count;
   $('#form_totalSinImpuestos').val(total);
});

}

function des(){
    var a=$('#form_totalSinImpuestos').val();
    var b= $('#form_totalDescuento').val();
    var bc=b/100;
    var c= Number(a)*Number(bc);
    var d=a-c;
    $('#form_totalSinImpuestos').val(d);
}

function doSearch()

        {

            const tableReg = document.getElementById('factura-table');

            const searchText = document.getElementById('bus').value.toUpperCase();

            let total = 0;

 

            // Recorremos todas las filas con contenido de la tabla

            for (let i = 1; i < tableReg.rows.length; i++) {

                // Si el td tiene la clase "noSearch" no se busca en su cntenido

                if (tableReg.rows[i].classList.contains("noSearch")) {

                    continue;

                }

 

                let found = false;

                const cellsOfRow = tableReg.rows[i].getElementsByTagName('td');

                // Recorremos todas las celdas

                for (let j = 0; j < cellsOfRow.length && !found; j++) {

                    const compareWith = cellsOfRow[j].innerHTML.toUpperCase();

                    // Buscamos el texto en el contenido de la celda

                    if (searchText.length == 0 || compareWith.indexOf(searchText) > -1) {

                        found = true;

                        total++;

                    }

                }

                if (found) {

                    tableReg.rows[i].style.display = '';

                } else {

                    // si no ha encontrado ninguna coincidencia, esconde la

                    // fila de la tabla

                    tableReg.rows[i].style.display = 'none';

                }

            }

 

            // mostramos las coincidencias

            const lastTR=tableReg.rows[tableReg.rows.length-1];

            const td=lastTR.querySelector("td");

            lastTR.classList.remove("hide", "red");

            if (searchText == "") {

                lastTR.classList.add("hide");

            } else if (total) {

                td.innerHTML="Se ha encontrado "+total+" coincidencia"+((total>1)?"s":"");

            } else {

                lastTR.classList.add("red");

                td.innerHTML="No se han encontrado coincidencias";

            }

        }

var oTable = $("#factura-table").dataTable({
    responsive: true,
    bAutoWidth: true,
    sAjaxSource: "{{ path('all_factura')}}",
    bProcessing: true,
    bServerSide: true,
    bSort: false,
    aLengthMenu: [[5, 10, 15], [5, 10, 15]],
    language: {
        sProcessing: "Procesando...",
        sLengthMenu: "Mostrar _MENU_",
        sZeroRecords: "No se encontraron resultados",
        sEmptyTable: "Ningún dato disponible en esta tabla",
        sInfo: "Mostrando del _START_ al _END_ de _TOTAL_ registros",
        sInfoEmpty: "Mostrando del 0 al 0 de un total de 0 registros",
        sInfoFiltered: "(filtrado de un total de _MAX_ registros)",
        sInfoPostFix: "",
        sSearch: "Buscar:",
        sUrl: "",
        sInfoThousands: ",",
        sLoadingRecords: "Cargando...",
        oPaginate: {
            sFirst: "Primero",
            sLast: "Último",
            sNext: "Siguiente",
            sPrevious: "Anterior"
        },
        oAria: {
            sSortAscending: ": Activar para ordenar la columna de manera ascendente",
            sSortDescending: ": Activar para ordenar la columna de manera descendente"
        },
    },
});



/*
$('.nuevoCliente').click(function() {
    alert("hola");
    $('#nuevoCliente').prop('checked', true);
    $('#nuevoCliente').val(true);
});
/*
$('#factura-table input').unbind();
$('#factura-table input').bind('keyup', function(e) {
    if (e.keyCode == 13) {
        oTable.fnFilter($(this).val());
    }
});*/
/*
$(document).ready(function(){
    fetchTarea();
    $('#factura-table').hide();
$('#bus').keyup(function(e){
    let search=$('#bus').val();
    $.ajax({
url:'FactelBundle:PagoCliente:index.html.twig',
type:'POST',
data: {search},
success: function(response){
    let tar= JSON.parse(response);
    let tem ='';
    tar.forEach(tarea => {
        tem += `<li>
        ${tarea.nombre}
        
        </li>`
    });
    $('#containerr').html(tem);
    $('#factura-table').show();
}
});
})
});

function fetchTarea(){
    $.ajax({
        url:'lista_tarea.php',
        type:'GET',
        success: function (response){
            let tar= JSON.parse(response);
            let tem ='';
            tar.forEach(tarea => {
                tem += `
                <tr taskId="${tarea.menuid}">
                <td>
                <a href="#" class="task-item">${tarea.nombre}</a>
                </td>
                <td>${tarea.descripcion}</td>
                <td>${tarea.id}</td>
               <td>
               <button class='tarea_borrar btn btn-danger'>
               Borrar
               </button>
               </td>
                </tr>
                `
            });
            $('#resultado').html(tem);
            
        }
    });
}*/