<%@page import="tw.com.bean.Item"%>
<%@page import="java.util.Collection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.0.0.js"></script>
<script src="https://code.jquery.com/jquery-migrate-3.0.1.js"></script>
<title></title>
</head>
<body>
	<table border="1" id="table">
		<thead>
			<tr>
				<th>ID</th>
				<th>Name</th>
				<th>Description</th>
				<th colspan="2">Actions</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${items}" var="item" varStatus="vs">
				<tr>
					<td>${vs.index + 1}</td>
					<td>${item.name}</td>
					<td>${item.description}</td>
					<td></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		var $tbody = $("#table > tbody")
		var items = getData()
		// var total = +'<%= ((Collection<Item>) request.getAttribute("items")).size() %>'
		var total = +'${fn:length(items)}'
		items.forEach(function(item, index) {
			var idx = total + index + 1
			var rowId = 'item' + idx
			var row = document.createElement('tr')
			var tdId = document.createElement('td')
			var tdName = document.createElement('td')
			var tdDescription = document.createElement('td')
			var tdAction = document.createElement('td')
			var deleteButton = document.createElement('button')
			
			deleteButton.append('Delete')
			deleteButton.onclick = function () {
				$tbody.children('#' + rowId).remove()
				$tbody.children().each(function() {
					var $td = $(this).children('td:first-child')
					var id = +($td.text() || 0)
					if (id > idx) {
						$td.text(id - 1)
					}
				})
			}
			
			row.setAttribute('id', rowId)
			tdId.append(idx)
			tdName.append(item.name)
			tdDescription.append(item.description)
			tdAction.appendChild(deleteButton)

			row.appendChild(tdId)
			row.appendChild(tdName)
			row.appendChild(tdDescription)
			row.appendChild(tdAction)
			$tbody.append(row)
		})
	})

	function getData() {
		return Object.create([ {
			id : 4,
			name : 'James',
			description : 'One Two Three',
		}, {
			id : 5,
			name : 'Bee',
			description : '＠＠你好！',
		}, ])
	}
</script>
</html>