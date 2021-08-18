require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")
require('jquery')
require("@fortawesome/fontawesome-free");

import '@fortawesome/fontawesome-free/js/all';
import "../stylesheets/application";
import "../stylesheets/touring.scss";
import 'bootstrap';

const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

$(function(){
  setTimeout("$('.flash').fadeOut('slow')", 2000);
});
