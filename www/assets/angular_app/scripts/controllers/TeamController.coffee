'use strict'

angular.module('subzapp_mobile').controller('TeamController', [
  '$scope'
  '$state'
  '$http'
  '$window'
  '$location'
  'message'
  'user'
  'RESOURCES'

  ($scope, $state, $http, $window, $location, message, user, RESOURCES ) ->
    console.log "Team Controller"
    user_token = window.localStorage.getItem 'user_token'

    if !(window.USER?)
      user.get_user().then ( (res) ->
        console.log "Got user"
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


    $http(
        method: 'GET'
        url: "#{ RESOURCES.DOMAIN }/get-team"
        headers: { 'Authorization': "JWT #{ user_token }", "Content-Type": "application/json" }
        params:
          team_id: $location.search().id
      ).then ( (res) ->
        console.log "Got team #{ JSON.stringify res }"
        $scope.team = res.data[0]
      ), ( errResponse ) ->
        console.log "Get team error #{ JSON.stringify errResponse }"

  
    $scope.join_team = (id) ->
      console.log "User #{ USER.id }"
      $http(
        method: 'POST'
        url: "#{ RESOURCES.DOMAIN }/join-team"
        headers: { 'Authorization': "JWT #{ user_token }", "Content-Type": "application/json" }
        data:
          user_id: USER.id
          team_id: $location.search().id
      ).then ( (res) ->
        console.log "Join team response #{ JSON.stringify res }"
        
      ), ( errResponse ) ->
        console.log "Join team error #{ JSON.stringify errResponse }"

  
        
])