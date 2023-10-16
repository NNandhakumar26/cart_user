import 'package:toyskart/global/app_service.dart';

abstract class ApiConst {
  ApiConst._();

  //static const String webHost = 'https://gigavus.hydrameet.net';
  static const String apiHost = 'https://mercury-toy.herokuapp.com';

  static const String middlePath = '/api/';

// menu
  static const String menuList = 'item/list';

//

  static const categories = "category";
  static const getCategories = "$categories/list/";
// cart
  static const cart = "cart";
  static var cartList = "$cart/list";
//
  static const orders = "order";

// address

  static const savedAddress = "saved-address";
  static var savedAddressList =
      "$savedAddress/${AppService.to.loggedUser[0].id}/list";
  static var savedAddressUpdate =
      "$savedAddress/${AppService.to.loggedUser[0].id}";

  //static String get user => '/user/${AppService.to.fireUser?.uid}/2';
  static const String forgotPasswordMail = '/auth/forget-password-email';

  /// Search
  static const String searchList = '/search/list';

  /// Calendar Events
  static const String calendarEventListBydate = '/post/list-by-date';

  static const String calenderEventList = "/post/calender-event-list";
  static const String userDetails = '/user/profile-details/';
  //   return 'user/profile-details/' + userId;
  // }

  // static const signUp = "auth/signin";
  // static const getUserdetails = "user/";
  // static const getAllCategories = "category/list/?type=1&categoryId=" "";

  // static const loginCount = "auth/login/";
  static const like = "/like";
  static const removeLike = "$like/removeLike";
  static const commentLike = "/comment-like";
  static const removecommentLike = "$commentLike/removeLike";
  static const profileLike = "/profile-like";
  static const removeprofileLike = "$profileLike/removeLike";
  // static const unlike = "unlike";
  // static const removeUnlike = unlike + "/remove-unlike";
  static const follower = "/follower";
  static const removeFollower = "$follower/remove-follower";
  static const bookmark = "/bookmark";
  static const removeBookmark = "$bookmark/remove-bookmark";
  static const comment = "/comment";
  // static const contact = "contact";
  static const posts = "/post";

  // static const addVideo = posts + "/video";
  // static const addEvent = posts + "/event";
  // static const addFeed = posts + "/feed";
  static const postViews = "/post-view";
  // static const cart = "/cart";
  static const report = "/report/";
  static const order = "/order";
  static const payment = "/payments";
  static const timeZone = "/dropdown/timezone-list";
  static const currencyZone = "/dropdown/currency-list";
  static const countryZone = "/dropdown/country-list";
  static const postsGet = '$posts/list';
  static const getAllComments = '$comment/list/';
  static String pinPost(String postId) => '/post/pin/$postId';

  static String categoriesList(String type, String catId) {
    return "/category/list/?type=$type&categoryId=$catId";
  }

  static const wishListRoot = "wish-list";
  static const wishList = "$wishListRoot/list";
  static const wishListRemove = "$wishListRoot/remove";

  // static videoDetails(postId, userId) {
  //   return posts + '/detail/' + postId + '/' + userId;
  // }

  // static getAllComments(postId, userId) {
  //   return comment + '/list/' + postId + '?loginUserId=' + userId;
  // }

  // static getuserActivities(userId, limit, offset) {
  //   return '
  // }

  static const profileImage = '/user/profile-image/';

  // static userDetails(userId) {
  //   return 'user/profile-details/' + userId;
  // }

  // static getTwoFA(userId) {
  //   return 'user/twofactor-auth/' + userId;
  // }

  // static updateTwoFA(type, userId) {
  //   return 'user/' + type + '/' + userId;
  // }

  // static verifyTwoFA() {
  //   return 'auth/twofactor-authentication';
  // }

  static const updateUserDetails = '/user/';

  static const getAllBookmaredItems = '$bookmark/list/';

  // static getAllContacts(userId) {
  //   return '/' + userId + '/list?limit=100&offset=0';
  // }

  // static getCartList(userId) {
  //   return cart + '/list/' + userId;
  // }

  // static getPurchaseList(userId) {
  //   return 'order/list/' + userId;
  // }

  // static postReport(userId) {
  //   return cart + '/list/' + userId;
  // }

  // static const String recentSearch = 'recent-search/list/';

  // static const String verifyEmail = 'auth/verify-email';
  // static const String forgotPasswordReset = 'auth/forget-password-reset';

  // static String followers() {
  //   return "follower/follow-list/${AppService.to.user!.id}";
  // }

  static const followerFollowing = "/follower/follow-list/";

  // static searchpost(text, limit, offset) {
  //   return "search/search-post?sqry=" +
  //       text +
  //       "&limit=" +
  //       limit +
  //       "&offset=" +
  //       offset;
  // }

  // static searchuser(text, limit, offset) {
  //   return "search/search-user?sqry=" +
  //       text +
  //       "&limit=" +
  //       limit +
  //       "&offset=" +
  //       offset;
  // }

  static const String getWebinarInfo = "/post/join-event";

  // static String chatUserSearch() =>
  //     "/follower/follow-list/${AppService.to.user!.id}";
  static const String invoiceGenerator = "/invoice";
  static const String generatelinkGoogle = "/user/google/generate-google-auth";
  static const String linkGoogle = "/user/google/link-account";
  static const String unLinkGoogle = "/user/google/unlink-account";
}
