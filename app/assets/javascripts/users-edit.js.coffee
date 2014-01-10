jQuery ->
	$('#user_city_ids').select2
		allowClear: true
		minimumInputLength: 2
		ajax:
			url: '/communities/search.json'
			type: 'GET'
			dataType: 'jsonp'
			data: (term, page) ->
				q: term
				type: $(this).data('type')
			results: (data, page) ->
				results: data
		formatResult: (object, container, query) ->
			return '<div><div>' + object.name + '</div><div>' + object.country_name + '</div></div>'
		formatSelection: (item) ->
			item.name + ", " + item.country_code
		initSelection: (element, callback) ->
			id = $(element).val()
			type = $(element).data('type')
			if id isnt "[]"
				$.ajax '/communities/search.json',
					type: 'GET'
					dataType: 'jsonp'
					data:
						id: id
						type: type
					success: (data) ->
						callback(data[0])

	$('#user_school_ids, #user_interest_ids').select2
		multiple: true
		allowClear: true
		ajax:
			url: '/communities/search.json'
			type: 'GET'
			dataType: 'jsonp'
			data: (term, page) ->
				q: term
				type: $(this).data('type')
			results: (data, page) ->
				results: data
		formatResult: (object, container, query) ->
			return '<div>' + object.name + '</div>'
		formatSelection: (item) ->
			item.name
		initSelection: (element, callback) ->
			id = $(element).val()
			type = $(element).data('type')
			if id isnt "[]"
				$.ajax '/communities/search.json',
					type: 'GET'
					dataType: 'jsonp'
					data:
						id: id
						type: type
					success: (data) ->
						callback(data)

	$(
		'#user_culture_ids,
		 #user_relationship_ids,
		 #user_orientation_ids,
		 #user_religion_ids,
		 #user_standing_ids,
		 #user_degree_ids,
		 #user_profession_ids,
		 #user_company_ids,
		 #user_field_ids'
	).select2
		allowClear: true
