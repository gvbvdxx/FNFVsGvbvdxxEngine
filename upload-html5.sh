cd "./export/release/html5/bin/"
git init
git add ./*
git commit -m "Upload website build"
git branch -M website
git remote add origin https://github.com/gvbvdxx/FNFVsGvbvdxxEngine.git
git push -f origin website