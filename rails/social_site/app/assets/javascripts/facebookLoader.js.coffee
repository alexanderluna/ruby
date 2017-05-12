$ ->
  loadFacebookSDK()
  bindFacebookEvents() unless window.fbEventsBound

bindFacebookEvents = ->
  $(document)
    .on('page:fetch', saveFacebookRoot)
    .on('page:change', restoreFacebookRoot)
    .on('page:load', ->
      FB?.XFBML.parse()
    )
  @fbEventsBound = true

saveFacebookRoot = ->
  if $('#fb-root').length
    @fbRoot = $('#fb-root').detach()

restoreFacebookRoot = ->
  if @fbRoot?
    if $('#fb-root').length
      $('#fb-root').replaceWith @fbRoot
    else
      $('body').append @fbRoot

loadFacebookSDK = ->
  window.fbAsyncInit = initializeFacebookSDK
  $.getScript("//connect.facebook.net/es_ES/sdk.js#xfbml=1&version=v2.8&appId=721817757980628")

initializeFacebookSDK = ->
  FB.init
    appId  : '721817757980628'
    image  : 'https://s3-us-west-2.amazonaws.com/hyouka/static_files/prayer.jpg'
    description: 'Un lugar para unirnos a orar'
    title  : 'Oraciones'
    status : true
    cookie : true
    xfbml  : true
    version: 'v2.8'
