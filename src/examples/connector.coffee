LOCATION = 'http://localhost:8070/'

class window.Connector
	
	constructor: (@game) ->
		console.log "connector is ready"
	
	
	submitAuthentication: () ->
		console.log "authentication submitted"
		$.ajax LOCATION,
		type: "POST"
		dataType: 'html'
		async: false
		data:
			request: 'authenticate'
			round: @game.getRound()
			stage: @game.getStage()
		error: (jqXHR, textStatus, errorThrown) =>
			@error(errorThrown)
		success: (data, textStatus, jqXHR) =>
			console.log "feedback: " + data
			if data >= 0
				@game.setId(data)
			else
				@error("illegal id was returned while trying to authenticate: " + data)
			
		console.log "Authenticated as: " + @game.getId()
		return(@game.getId())
	
	
	submitAngle: (angle) ->
		console.log "submitting angle for game id: " + @game.getId()
		@resp = null
		$.ajax LOCATION,
		type: "POST"
		dataType: 'html'
		async: false
		data:
			request: 'angle'
			round: @game.getRound()
			stage: @game.getStage()
			id: @game.getId()
			angle: angle
		error: (jqXHR, textStatus, errorThrown) =>
			@error(errorThrown)
		success: (data, textStatus, jqXHR) => 
			@resp = data
			return
		console.log "submitted: " + angle + "\t response: " + @resp
		return(@resp)
	
	requestMean: () ->
		console.log "requesting mean for game id: " + @game.getId()
		@mean = -1
		$.ajax LOCATION,
		type: "POST"
		dataType: 'html'
		async: false
		data:
			request: 'mean'
			round: @game.getPreviousRound()
			stage: @game.getPreviousStage()
			id: @game.getId()
		error: (jqXHR, textStatus, errorThrown) =>
			@error(errorThrown)
		success: (data, textStatus, jqXHR) =>
			@mean = data
			console.log "mean angle: " + @mean
		return(@mean)
	
	
	requestNext: () ->
		console.log "Requesting for next"
		next = 0
		$.ajax LOCATION,
		type: "POST"
		dataType: 'html'
		async: false
		data:
			request: 'next'
			round: @game.getRound()
			stage: @game.getStage()
			id: @game.getId()
		error: (jqXHR, textStatus, errorThrown) =>
			alert "Failure"
			@error(errorThrown)
		success: (data, textStatus, jqXHR) =>
			next = data
			console.log "to next: " + next
		return next
	
	
	
	
	submit: (request, specData, success, result) =>
		data=
			request: request
			round: @game.getRound()
			stage: @game.getStage()
		$.merge data, specData
		
		$.ajax LOCATION,
		type: "POST"
		dataType: 'html'
		async: false
		data: data
		error: (jqXHR, textStatus, errorThrown) =>
			@error(errorThrown)
		success: success
		return(result)
	
	
	
	error: (code) ->
		console.log "Ajax error. Error code: " + code		
	
	

