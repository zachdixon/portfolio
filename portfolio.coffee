if Meteor.isClient
  projects = [
    _id: 1, title:"SocialCentiv", hasLink:true, url:"http://socialcentiv.com", link: "http://socialcentiv.com", imgSrc:"/images/socialcentiv.png", description:"Lead generation with Twitter marketing for small businesses", skills:["BatmanJS", "CoffeeScript", "SCSS", "jQuery", "MVC", "REST API"]
  ,
    _id: 2, title:"Homemovies", hasLink:true, url:"http://homemovi.es", link: "http://homemovi.es", imgSrc:"/images/homemovies.png", description: "Find movie information and create custom watchlists", skills:["MeteorJS", "MongoDB", "NodeJS", "CoffeeScript", "LESS", "JSON API", "Design", "UX"]
  ,
    _id: 3, title:"SocialCompass", hasLink:false, imgSrc:"/images/socialcompass.png", description:"Social Media Management Tool for Agencies", skills:["CoffeeScript", "jQuery", "AJAX", "SCSS"]
  ,
    _id: 4, title:"Dixon Family", hasLink:true, url: "http://dixon.meteor.com", link: "Work in Progress", imgSrc: "/images/dixon.png", description: "Personal site for my family name", skills:["MeteorJS", "Polymer", "Material Design", "CoffeeScript", "LESS"]
  ,
    _id: 5, title:"Secretary", hasLink:false, imgSrc: "/images/secretary.png", description: "Practice Project: Internal calendar and event scheduler built with MeteorJS", skills: ["MeteorJS", "Bootstrap 3", "MongoDB", "CoffeeScript", "SCSS"]
  ,
    _id: 6, title:"Guardrail", hasLink:false, imgSrc: "/images/guardrail.png", description: "Practice Project: Internal tests, issues, feature requests tracker built with MeteorJS", skills: ["MeteorJS", "Bootstrap 3", "MongoDB", "CoffeeScript", "SCSS"]
  ]

  Template.layout.rendered = ->
    new WOW().init()
    $('.parallax').parallax()

  Template.layout.events
    'click a[data-scroll]': (e) ->
      e.preventDefault()
      $('html, body').animate
        scrollTop: $($(e.currentTarget).attr('href')).offset().top
      , 1000

  Template.work.helpers
    projects: projects

  Template.contact.events
    'submit #form-contact': (e, doc) ->
      e.preventDefault()
      name = doc.find('#contact-name').value
      subject = "Portfolio: from #{name}"
      from = doc.find('#contact-email').value
      message = doc.find('#contact-message').value
      Meteor.call 'sendEmail', undefined, from, subject, message, (error, result) ->
        $(doc.find('.input-row')).fadeOut 'fast', ->
          @.remove()
          $(doc.find('.feedback-text')).fadeIn()


if Meteor.isServer
  Meteor.methods sendEmail: (to, from, subject, text) ->
    unless to then to = "rissk13@gmail.com"
    check [ to, from, subject, text ], [ String ]
    @unblock()
    Email.send
      to: to
      from: from
      subject: subject
      text: text
  Meteor.startup ->
