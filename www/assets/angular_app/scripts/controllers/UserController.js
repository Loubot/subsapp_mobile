// Generated by CoffeeScript 1.10.0
'use strict';
angular.module('subzapp_mobile').controller('UserController', [
  '$scope', '$state', '$http', '$window', 'message', 'user', 'RESOURCES', function($scope, $state, $http, $window, message, user, RESOURCES) {
    var user_token;
    console.log("User Controller");
    if (!(window.USER != null)) {
      user.get_user().then((function(res) {
        console.log("User set to " + (JSON.stringify(res)));
        return res;
      }), function(errResponse) {
        console.log("User get error " + (JSON.stringify(errResponse)));
        $state.go('login');
        return false;
      });
    } else {
      console.log("User already defined");
    }
    user_token = window.localStorage.getItem('user_token');
    return $http({
      method: 'GET',
      url: RESOURCES.DOMAIN + "/get-org-list",
      headers: {
        'Authorization': "JWT " + user_token,
        "Content-Type": "application/json"
      }
    }).success(function(orgs) {
      console.log("Fetched user data " + (JSON.stringify(orgs)));
      return $scope.orgs = orgs;
    }).error(function(err) {
      console.log("Fetching user data error " + (JSON.stringify(err)));
      return $state.go('login');
    });
  }
]);
