# ada_description [![Build Status](https://travis-ci.com/personalrobotics/ada_description.svg?token=1MmAniN9fkMcwpRUTdFq&branch=master)](https://travis-ci.com/personalrobotics/ada_description)
urdf files for ADA

## Making changes

Do not make edits to `.urdf` files in `/robots_urdf` directly if you want to keep your changes persisted. Instead:

- Make changes to `.xacro` files in the `/robots` directory
- Run `./process_xacros.bash`
