'use strict'

angular.module('subzapp_mobile').controller('OrgController', [
  '$scope'
  '$state'
  '$http'
  '$window'
  '$location'
  'message'
  'user'
  'RESOURCES'

  ($scope, $state, $http, $window, $location, message, user, RESOURCES ) ->

    console.log "Org Controllersss"

    if !(window.USER?)
      user.get_user().then ( (res) ->
        # console.log "User set to #{ JSON.stringify res }"
        # console.log "user controller #{JSON.stringify window.USER }"
        # $scope.orgs = window.USER.orgs
        return res
      ), ( errResponse ) ->
        console.log "User get error #{ JSON.stringify errResponse }"
        $state.go 'login'
        return false
    else
      console.log "User already defined"

    console.log "params " + JSON.stringify $location.search().id
    user_token = window.localStorage.getItem 'user_token'
    $http(
      method: 'GET'
      url: "#{ RESOURCES.DOMAIN }/get-single-org"
      headers: { 'Authorization': "JWT #{ user_token }", "Content-Type": "application/json" }
      params: 
        org_id: $location.search().id
    ).success( (org) ->
      console.log "Fetched user data #{ JSON.stringify org }"
      $scope.org = org
      # 
    ).error (err) ->
      console.log "single org error #{ JSON.stringify err }"
      # $state.go 'login'


])