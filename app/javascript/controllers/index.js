// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import BookIndexController from "./book_index_controller"
application.register("book-index", BookIndexController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import MovieIndexController from "./movie_index_controller"
application.register("movie-index", MovieIndexController)

import MusicIndexController from "./music_index_controller"
application.register("music-index", MusicIndexController)

import MyCreatorIndexController from "./my_creator_index_controller"
application.register("my-creator-index", MyCreatorIndexController)

import MyCreatorNewController from "./my_creator_new_controller"
application.register("my-creator-new", MyCreatorNewController)

import MyFavoritesIndexController from "./my_favorites_index_controller"
application.register("my-favorites-index", MyFavoritesIndexController)

import SummariesIndexController from "./summaries_index_controller"
application.register("summaries-index", SummariesIndexController)

import TestController from "./test_controller"
application.register("test", TestController)
