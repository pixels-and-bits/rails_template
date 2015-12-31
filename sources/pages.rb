generate 'controller pages home'

file_inject 'app/controllers/pages_controller.rb',
  'class PagesController < ApplicationController',
  "  include PublicController\n",
  :after
