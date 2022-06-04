import sys
import os
import pyrebase
import time


def replace_defaultconf(web):
    with open('/home/ubuntu/kubernetes/front/default.conf', 'r') as f:
        oce=f.read()

    linea="""    location /"""+web+""" {
            proxy_pass http://"""+web+"""-tcp:80;
        }

        \n#"""
    oce=oce.replace("#",linea)
    with open('/home/ubuntu/kubernetes/front/default.conf', 'w') as w:
        w.write(oce)
        w.close()

def deploy(to_deploy_list):
    webs_actuales_file = open("websactuales.txt","a")
    for web in to_deploy_list:                                                                                                                                                                                                        #aqui pod
        os.system("sed -i 's/front/{0}/g' deployment.yaml &&  sed -i 's/replacethis/{1}/' deployment.yaml && microk8s kubectl apply -f deployment.yaml &&  sed -i 's/{1}/replacethis/' deployment.yaml && sed -i 's/{0}/front/g' deployment.yaml".format(web.replace("\n","").replace("@","").replace(".",""),web.replace("\n","")))#kubectl apply -f
        replace_defaultconf(web.replace("\n","").replace("@","").replace(".",""))
        os.system("cd ../front && docker login && docker build -t edujc/test0 . && docker push edujc/test0 && microk8s kubectl apply -f deployment.yaml && microk8s kubectl rollout restart deployment front")
        webs_actuales_file.write(web)

    open("todeploy.txt","w").close()





def __main__():

    while True:

        config = {
            "apiKey": "AIzaSyAwsc4xjPgD9bbvbFVZSwX8GWqG87I6kRk",
            "authDomain": "ejemploflutt.firebaseapp.com",
            "databaseURL": "https://ejemploflutt-default-rtdb.europe-west1.firebasedatabase.app/",
            "projectId": "ejemploflutt",
            "storageBucket": "ejemploflutt.appspot.com",
            "messagingSenderId": "666354346390",
            "appId": "1:666354346390:android:6f86829d316a1427e755b7",
            "serviceAccount": "./ejemploflutt-firebase-adminsdk-grxtc-530b1f2cf0.json",
            "measurementId": ""

        }


        webs_actuales_file = open("websactuales.txt","r")
        webs_actuales = webs_actuales_file.readlines()
        webs_actuales_file.close()
        to_deploy = open("todeploy.txt","w")


        ###
        # mirar si está, si no está que pase a to deplopy desde ahi hará un bucle con su longitud en el que primero hará el deployment luego pasará al siguiente y cuando esté listo el bucle borrará todo de toDeploy
        # y lo pondrá en el webactuales
        #
        #
        ###

        firebase = pyrebase.initialize_app(config)





        storage = firebase.storage()




        all_files = storage.child("webpages/").list_files()

        for file in all_files:
            if file.name.startswith("webpages/"):

                if file.name.replace("webpages/","")+"\n" not in webs_actuales:
                    to_deploy.write(file.name.replace("webpages/","")+"\n")










        to_deploy.close()
        to_deploy = open("todeploy.txt","r")
        to_deploy_list=to_deploy.readlines()
        to_deploy.close()
        deploy(to_deploy_list)
        print("done")
        time.sleep(40)



__main__()