'use strict'

angular.module('subzapp_mobile').controller('EditUserController', [
  '$scope'
  '$state'
  '$http'
  '$window'
  'message'
  'user'
  'RESOURCES'
  'stripe'
  ( $scope, $state, $http, $window, message, user, RESOURCES, stripe ) ->
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


    ### Stripe payments ###
    
    stripe.setPublishableKey('pk_test_bfa4lYmoaJZTm9d94qBTEEra')
    console.log stripe
    # stripeProvider.setPublishableKey('pk_test_bfa4lYmoaJZTm9d94qBTEEra')


])
