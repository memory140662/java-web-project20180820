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
<title></title>
</head>
<body>
	<form action="<%= request.getContextPath() %>/" method="POST">
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
		<input type="hidden" name="items">	
	</form>
	<button type="button" onclick="submit()">Submit</button>
	
</body>
<script type="text/javascript">
	window.onload = function() {
		var tbody = document.querySelector('#table > tbody')
		var items = getData()
		
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
				var tempNode = null
				var index = null
				for (var i = 0; i < tbody.childNodes.length; i++) {
					var node = tbody.childNodes[i] 
					if (index) {
						node.childNodes[0].innerText = index++
					}
					if (rowId === node.id) {
						tempNode = node
						index = +node.childNodes[0].innerText
					}
				}
				if (tempNode) {
					tbody.removeChild(tempNode)
				} 
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
			tbody.appendChild(row)
		})	
	}

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
	
	function submit() {
		var origItems = ${jsonItems}
		var newItems = [{id: 5, name: '123'}]
		var nodes = document.querySelectorAll('#table > tbody > tr')
		var $items = document.querySelector('input[name=items]')
		var $form = document.querySelector('form')
		$items.setAttribute('value', JSON.stringify(origItems.concat(newItems)))
		$form.submit()
	}
</script>
</html>