'use strict'

angular.module('subzapp_mobile').controller('EditUserController', [
  '$scope'
  '$state'
  '$http'
  '$window'
  'message'
  'user'
  'RESOURCES'
  ( $scope, $state, $http, $window, message, user, RESOURCES ) ->
    console.log 'EditUser Controller'
    
    user_token = window.localStorage.getItem 'user_token'
    if !(window.USER?)
      user.get_user().then ( (res) ->
        # console.log res
                
        $scope.orgs = window.USER.orgs
        $scope.user = USER
      ), ( errResponse ) ->
        console.log "User get error #{ JSON.stringify errResponse }"
        window.USER = null
        $state.go 'login'
    else 
      console.log 'else'
      $scope.orgs = window.USER.orgs
      $scope.user = USER

    stripeResponseHandler = (status, response) ->
      console.log status
      console.log response

    Stripe.setPublishableKey('pk_test_bfa4lYmoaJZTm9d94qBTEEra')

    $('#payment-form').submit (event) ->
      console.log Stripe
      event.preventDefault()
      $form = $(this)
      # Disable the submit button to prevent repeated clicks
      $form.find('button').prop 'disabled', true
      Stripe.card.createToken $form, stripeResponseHandler
      # Prevent the form from submitting with the default action
      false


    $scope.edit_user = ->
      # console.log $scope.user
      # $scope.user.user_id = USER.id
      $http(
        method: 'POST'
        url: "#{ RESOURCES.DOMAIN }/edit-user"
        headers: { 'Authorization': "JWT #{ user_token }", "Content-Type": "application/json" }
        data: 
          id: $scope.user.id
          firstName: $scope.user.firstName
          lastName: $scope.user.lastName
      ).then ( (response) ->
        console.log "Edit user response #{ JSON.stringify response }"
        message.success('User updated ok')
      ), ( errResponse ) ->
        console.log "Edit user error #{ JSON.stringify errResponse }"
        message.errir JSON.stringify errResponse

    $scope.stripe_submit = ->
      console.log 'stripe'

    $scope.add_validation = (e) ->
      console.log "he hey"
      t = e.target
      $(t).addClass('validation')
      console.log e
      return true


])
