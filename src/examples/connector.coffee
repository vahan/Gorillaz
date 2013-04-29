LOCATION = 'http://localhost:8070/'

class window.Connector
	
	constructor: (@game) ->
		@id = -1
		console.log "connector is ready"
		
	
	submitAuthentication: () ->				
		$.ajax LOCATION,
		type: "POST"
		dataType: 'html'
		async: false
		request: 'authenticate'
		round: @game.getRound()
		stage: @game.getStage()
		error: (jqXHR, textStatus, errorThrown) =>
			@authenticationError(@id)
		success: (data, textStatus, jqXHR) =>
			console.log "feedback: " + data
			if data >= 0
				@id = data
			else
				@authenticationError(@id)	
			
		
		console.log "Authenticated as: " + @id
		return(@id)
	
	
	submitAngle: (angle) ->
		@resp = null
		$.post LOCATION,
			request: 'angle'
			round: @game.ROUND
			stage: @game.STAGE
			id: @game.ID
			angle: angle
			success: (data, textStatus, jqXHR) => 
				@resp = data
				console.log "feedback: " + data
				return
		console.log "submitted: " + angle + "\t response: " + @resp
		return(@resp)
		
	
	requestMean: () ->
		@mean = -1
		$.post LOCATION,
			request: 'mean'
			round: @game.ROUND
			stage: @game.STAGE
			id: @game.ID
			success: (data, textStatus, jqXHR) =>
				@mean = data
				console.log "mean angle: " + @mean
		
		return(@mean)
	
	authenticationError: (code) ->
		console.log "Can't authenticate; error code: " + code		