#!/usr/bin/env ./script/runner

# attachement_fu scripting
# ====================================

# You may wish to import a large number of images or attachments.
# The following example shows how to upload a file from a script.

# required to use ActionController::TestUploadedFile
require 'action_controller'
require 'action_controller/test_process.rb'

# image path
# path = "./public/images/x.jpg"
path = $1

# mimetype is a string like "image/jpeg". One way to get the mimetype for a given file on a UNIX system

# mimetype = "image/jpeg"
mimetype = `file -ib #{path}`.gsub(/\n/,"")

# This will "upload" the file at path and create the new model.
@attachable = AttachmentMetadataModel.new(:uploaded_data => ActionController::TestUploadedFile.new(path, mimetype))
@attachable.save
