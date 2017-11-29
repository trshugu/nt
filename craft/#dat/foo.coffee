###
class @Foo
  @methodA: ->
    "foo" + @methodB()

  methodB: ->
    "vee"
###


###
class Foo
  methodA: ->
    "foo" + @methodB()

  methodB: ->
    "vee"

module.exports.Foo = Foo
###

###
class @Foo
  methodA: =>
    "foo" + @methodB()

  methodB: ->
    "vee"
###



