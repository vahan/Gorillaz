fs = require 'fs'

{print} = require 'sys'
{spawn} = require 'child_process'

individual_file_args = ['-c', '-j', 'examples/js/gorillas.js', 
	'src/examples/connector.coffee',
	'src/examples/gorillas.coffee']

# Listing files in order here -- order matters becauase of class inheiritance
joined_file_args = ['-c', '-j', 'examples/js/easelBox.js', 
  'src/easelBox/easelBoxObject.coffee',
  'src/easelBox/easelBoxLandscapeRectangle.coffee',
  'src/easelBox/easelBoxMonkey.coffee',
  'src/easelBox/easelBoxWorld.coffee',
  'src/easelBox/easelBoxBox.coffee',
  'src/easelBox/easelBoxBanana.coffee',
  'src/easelBox/easelBoxContactListener.coffee',
  'src/easelBox/easelBoxArrow.coffee'
]

messages = (coffee) ->
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on 'data', (data) ->
    print data.toString()

task 'build', 'Build all changes', ->
  coffee = spawn 'coffee', individual_file_args
  messages coffee
  coffee = spawn 'coffee', joined_file_args
  messages coffee
  coffee.on 'exit', (code) ->
    callback?() if code is 0
  
task 'watch', 'Watch for changes', ->
  coffee = spawn 'coffee', ['-w'].concat(individual_file_args)
  messages coffee
  coffee = spawn 'coffee', ['-w'].concat(joined_file_args)
  messages coffee
