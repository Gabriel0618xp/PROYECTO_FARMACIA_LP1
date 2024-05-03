<%@page import="com.farmacia.dao.ClienteDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<!-- Libreria Bootstrap v3 (adaptado) -->
<link rel="stylesheet" href="css/bootstrapV3.css">

<!-- Librer�a Jquery v3.7.1-->
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>

<!-- Librer�a Bootstrap v5.3.3 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<!-- Bootstrao-Select v1.14.0-beta3 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.14.0-beta3/dist/css/bootstrap-select.min.css">

<!-- 
	Librer�a Bootstrap-select(v1.14.0-gamma1) NoOficial 
	Author: mattymatty76
-->
<script src="js/bootstrap-select(v1.14.0-gamma1).js"></script>

<!-- Librer�a SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- Librer�a BootstrapValidator -->
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.1/css/bootstrapValidator.min.css"/>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.1/js/bootstrapValidator.min.js"></script>

<!-- Librer�a DataTable -->
<link href="https://cdn.datatables.net/2.0.3/css/dataTables.bootstrap5.min.css" rel="stylesheet">
<link href="https://cdn.datatables.net/responsive/3.0.1/css/responsive.bootstrap5.css" rel="stylesheet">
<link href="https://cdn.datatables.net/buttons/3.0.1/css/buttons.dataTables.css" rel="stylesheet">
<script src="https://cdn.datatables.net/2.0.3/js/dataTables.min.js"></script>
<script src="https://cdn.datatables.net/2.0.3/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/responsive/3.0.1/js/dataTables.responsive.js"></script>
<script src="https://cdn.datatables.net/responsive/3.0.1/js/responsive.bootstrap5.js"></script>
<script src="https://cdn.datatables.net/buttons/3.0.1/js/dataTables.buttons.js"></script>
<script src="https://cdn.datatables.net/buttons/3.0.1/js/buttons.dataTables.js"></script>
<script src="https://cdn.datatables.net/buttons/3.0.1/js/buttons.colVis.min.js"></script>

<!-- Librer�a moment -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

<title>Cliente</title>

<style type="text/css">
	.icon-ns{
  	width: 25px;
  }
</style>

</head>
<body>

<div class="container">
	<c:set var="lista_cli" value="<%= new ClienteDAO().listadoCliente() %>" />
	
	<%@ include file="componentes/menu.jsp" %>
	
	<div class="row mt-4">
		<div class="col-md-9">
			<h1>Gestion de clientes</h1>				
		</div>
		<div class="col-md-3 align-self-center">
			<button id="btnAgregar" type="button" class="btn btn-success d-flex align-items-center gap-2 justify-content-center" data-bs-toggle="modal" data-bs-target="#modalRegistro">
				<img src="img/agregar-blanco.png" class="icon-ns" >Agregar Cliente
			</button>
		</div>
	</div>
	
	<div class="table-responsive mt-4">
		<table class="table table-striped display responsive nowrap" id="mydatatable"  style="width:100%">
	 		<thead>
		  		<tr>
						<th >Codigo</th>
						<th>DNI</th>
						<th>Nombre</th>
						<th>Apellido</th>
						<th>Acciones</th>
		  		</tr>
			</thead>
			<tbody>
				<c:forEach var="cli" items="${pageScope.lista_cli}">
					<tr>
						<td>${cli.getCod_cli()}</td>
						<td>${cli.getDni_cli()}</td>
						<td>${cli.getNom_cli()}</td>
						<td>${cli.getApe_cli()}</td>
						<td>
							<button 
								type="button" 
								class="btn btn-dark btnEditar" 
								data-bs-toggle="modal" 
								data-bs-target="#modalRegistro"
							>Editar</button>
							<button 
								type="button" 
								class="btn btn-danger btnEliminar" 
								data-bs-toggle="modal" 
								data-bs-target="#eliminarModal"
							>Eliminar</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
	 	</table>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="modalRegistro" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="titleModalRegistro">Registrar/Modificar Cliente</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="${pageContext.servletContext.contextPath}/gestionCliente" role="form" method="post" class="d-flex flex-column gap-4" id="frmCliente">
      		<input type="hidden" class="form-control" id="codigo" name="codigo">
        	<div class="row">
	        	<div class="form-group">
	      			<label>DNI</label>
	      			<input type="text" class="form-control" id="dni" name="dni" placeholder="Ingrese el DNI">
	     			</div>
        	</div>
        	<div class="row">
	        	<div class="form-group">
	      			<label>Nombre</label>
	      			<input type="text" class="form-control" id="nombre" name="nombre" placeholder="Ingrese el nombre">
	     			</div>
        	</div>
        	<div class="row">
	     			<div class="form-group">
	      			<label>Apellido</label>
	      			<input type="text" class="form-control" id="apellido" name="apellido" placeholder="Ingrese el apellido">
	     			</div>
        	</div>
        	<div class="row">
	        	<div class="d-grid gap-2 d-md-flex justify-content-md-end">
	             <button type="submit" class="btn btn-success d-none" name="accion" value="Actualizar" id="btnActualizar">Actualizar</button>
	             <button type="submit" class="btn btn-success" name="accion" value="Agregar" id="btnGuardar">Guardar</button>
	             <button type="button" class="btn btn-info" data-bs-dismiss="modal">Cancelar</button>
	         	</div>
        	</div>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- Modal Eliminar-->
<div class="modal fade" id="eliminarModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">ADVERTENCIA</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="frmEliminarCliente" action="gestionCliente" method="post">
        	<input type="hidden" class="form-control" name="codigo" id="cod-eliminar">
        	<h3>�Seguro de eliminar?</h3>
        	<div class="d-md-flex justify-content-md-end gap-2 mt-4">
        		<button type="submit" class="btn btn-primary" name="accion" value="Eliminar">Si</button>
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
        	</div>
        </form>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		
		// Aplicando validaciones
		$('#frmCliente').bootstrapValidator({
			message: 'This value is not valid',
			feedbackIcons: {
		        valid: 'glyphicon glyphicon-ok',
		        invalid: 'glyphicon glyphicon-remove',
		        validating: 'glyphicon glyphicon-refresh'
		  },
		  fields:{
			  dni:{
				  validators:{
	  			  notEmpty:{
	  				  message: 'Producto es obligatorio'
	  			  }
				  }
			  },
			  nombre:{
				  validators:{
	  			  notEmpty:{
	  				  message: 'Producto es obligatorio'
	  			  }
				  }
			  },
			  apellido:{
				  validators:{
	  			  notEmpty:{
	  				  message: 'Producto es obligatorio'
	  			  }
				  }
			  }
	    }
		});
		
		$('#mydatatable').DataTable({
			language: {
				url: '//cdn.datatables.net/plug-ins/2.0.3/i18n/es-ES.json',
			},
			responsive: true,
			columnDefs: [
		    { responsivePriority: 1, targets: 4 },
		    { responsivePriority: 1, targets: 3 },
		    { responsivePriority: 1, targets: 2 }
		  ]
		});
		
		$('.btnEditar').on('click', function(){
			const cod = $(this).parents("tr").find("td")[0].innerHTML;
			const dni = $(this).parents("tr").find("td")[1].innerHTML;
			const nombre = $(this).parents("tr").find("td")[2].innerHTML;
			const apellido = $(this).parents("tr").find("td")[3].innerHTML;
			
			$('#codigo').val(cod);
			$('#dni').val(dni);
			$('#nombre').val(nombre);
			$('#apellido').val(apellido);
			
			$('#btnActualizar').removeClass('d-none');
		  $('#btnGuardar').addClass('d-none');
		  
		  $('#titleModalRegistro').text('Modificar Cliente');
		});
		
		$('#btnAgregar').on('click', function(){
		  $('#btnGuardar').removeClass('d-none');
		  $('#btnActualizar').addClass('d-none');
		  
		  $('#titleModalRegistro').text('Registrar Cliente');
		});
		
		$('.btnEliminar').on('click', function(){
			const cod = $(this).parents("tr").find("td")[0].innerHTML;
			
			console.log(cod);
			
			$("#cod-eliminar").val(cod);
		});
	});
</script>
<c:if test="${not empty sessionScope.title}">
  <script type="text/javascript">
      $(document).ready(function(){   
          Swal.fire({
              position: "center",
              icon: "<%=request.getSession().getAttribute("icon")%>",
              title: "<%=request.getSession().getAttribute("title")%>",
              text:	"<%=request.getSession().getAttribute("text")%>",
              showConfirmButton: true,
              timer: 3000
          });
      });
  </script>
  <% session.removeAttribute("title"); %>
  <% session.removeAttribute("text"); %>
  <% session.removeAttribute("icon"); %>
</c:if>
</body>
</html>
