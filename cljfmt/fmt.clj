(ns fmt
  (:require [rewrite-clj.zip :as z]))

(defn only-plugins-and-cljfmt
  [sexpr]
  (let [[defproj proj version & {:keys [plugins cljfmt test-paths]}] sexpr]
    (list
     defproj proj version
     :plugins    (filterv (fn [[k v]] (= k 'lein-cljfmt)) plugins)
     :cljfmt     cljfmt
     :test-paths test-paths)))

(defn -main [& args]
  (-> (z/of-file "/app/project.clj")
      (z/edit only-plugins-and-cljfmt)
      z/root-string
      ((partial spit "/app/project.clj"))))
