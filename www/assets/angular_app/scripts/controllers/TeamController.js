// Generated by CoffeeScript 1.10.0
'use strict';
angular.module('subzapp_mobile').controller('TeamController', [
  '$scope', '$state', '$http', '$window', '$location', 'message', 'user', 'RESOURCES', function($scope, $state, $http, $window, $location, message, user, RESOURCES) {
    var user_token;
    console.log("Team Controller");
    user_token = window.localStorage.getItem('user_token');
    if (!(window.USER != null)) {
      user.get_user().then((function(res) {
        console.log("Got user");
        return res;
      }), function(errResponse) {
        console.log("User get error " + (JSON.stringify(errResponse)));
        $state.go('login');
        return false;
      });
    } else {
      console.log("User already defined");
    }
    $http({
      method: 'GET',
      url: RESOURCES.DOMAIN + "/get-team",
      headers: {
        'Authorization': "JWT " + user_token,
        "Content-Type": "application/json"
      },
      params: {
        team_id: $location.search().id
      }
    }).then((function(res) {
      console.log("Got team " + (JSON.stringify(res)));
      return $scope.team = res.data[0];
    }), function(errResponse) {
      return console.log("Get team error " + (JSON.stringify(errResponse)));
    });
    return $scope.join_team = function(id) {
      console.log("User " + USER.id);
      return $http({
        method: 'POST',
        url: RESOURCES.DOMAIN + "/join-team",
        headers: {
          'Authorization': "JWT " + user_token,
          "Content-Type": "application/json"
        },
        data: {
          user_id: USER.id,
          team_id: $location.search().id
        }
      }).then((function(res) {
        return console.log("Join team response " + (JSON.stringify(res)));
      }), function(errResponse) {
        return console.log("Join team error " + (JSON.stringify(errResponse)));
      });
    };
  }
]);
