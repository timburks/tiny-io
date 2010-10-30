;; Nukefile for Nunja-based Xmachine app

(task "zip" is
      (SH "rm -rf build/TinyIO.app")
      (SH "mkdir -p build/TinyIO.app")
      (SH "cp -r TinyIO build/TinyIO.app/TinyIO")
      (SH "cp -r public build/TinyIO.app")
      (SH "cd build; zip -r TinyIO.zip TinyIO.app"))

(task "default" => "zip")
