# record.js.coffee

@Record = React.createClass

	getInitialState: ->
		edit: false

	handleDelete: (e) ->
		e.preventDefault()
		$.ajax
			method: 'DELETE'
			url: "/records/#{ @props.record.id }"
			dataType: 'JSON'
			success: () =>
				@props.handleDeleteRecord @props.record
	
	handleToggle: (e) ->
		e.preventDefault()
		@setState edit: !@state.edit

	handleEdit: (e) ->
		e.preventDefault()
		data =
			title: ReactDOM.findDOMNode(@refs.title).value
			date: ReactDOM.findDOMNode(@refs.date).value
			amount: ReactDOM.findDOMNode(@refs.amount).value
		$.ajax
			method: 'PUT'
			url: " /records/#{@props.record.id} "
			dataType: 'JSON'
			data:
				record: data
			success: (data) =>
				@setState edit: false
				@props.handleEditRecord @props.record, data

	recordRow: ->
		React.DOM.tr null,
			React.DOM.td null, @props.record.date
			React.DOM.td null, @props.record.title
			React.DOM.td null, amountFormat(@props.record.amount)
			React.DOM.td null, 
				React.DOM.a
					className: 'btn btn-danger'
					onClick: @handleDelete
					'Delete'
				React.DOM.a
					className: 'btn btn-success'
					onClick: @handleToggle
					'Edit'
	
	recordForm: ->
		React.DOM.tr null,
			React.DOM.td null,
				React.DOM.input
					className: 'form-control'
					type: 'date'
					defaultValue: @props.record.date
					ref: 'date'
			React.DOM.td null,
				React.DOM.input
					className: 'form-control'
					type: 'text'
					defaultValue: @props.record.title
					ref: 'title'
			React.DOM.td null,
				React.DOM.input
					className: 'form-control'
					type: 'number'
					defaultValue: @props.record.amount
					ref: 'amount'
			React.DOM.td null,
				React.DOM.a
					className: 'btn btn-success'
					onClick: @handleEdit
					'Update'
				React.DOM.a
					className: 'btn btn-danger'
					onClick: @handleToggle
					'Cancel'
	render: ->
		if @state.edit
			@recordForm()
		else
			@recordRow()

