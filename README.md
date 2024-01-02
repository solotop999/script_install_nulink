![image](https://github.com/solotop999/script_install_nulink/assets/24671262/91ecd6a7-0432-4686-a748-21c250979320)
# NuLink Testnet Horus 2.0
- [Submit Form](https://docs.google.com/forms/d/e/1FAIpQLSdY2eXwQD-tKvJ_Ug-6hgdcWK_wUOZjXeJknw5XWSEO8gzJ2w/viewform)
- [More Info](https://www.nulink.org/blog-posts/nulink-testnet-horus-2-0-phase-one-testing-rules)
- [Dashboard | Faucet](https://dashboard.testnet.nulink.org/)
- [Video Tutorial](https://x.com/solotop999/status/1742176214155198899?s=20)

![nlk](https://github.com/Lorento34/NuLink-Testnet-Horus-2.0/assets/84406096/5942336a-d881-4c50-8504-63fc6609c957)


<h1>Minimum System Requirements<h6>

 - Debian/Ubuntu 20.04 (Recommended)
 - 4 GB Ram
 - 30GB Available Storage
 - Minimum 2 CPU processors
 - x86 Architecture
 - Static IP address
 - Exposed TCP port 9151, make sure it's not occupied
 - Nodes can be run on cloud infrastructure

<h1> NuLink Worker Installer steps for Ubuntu 22.04<h4>



- Prepare:
  
```
 sudo apt install ufw -y
 sudo ufw enable
 sudo ufw allow 9151
 apt update -y
 apt install git -y
```


- Install and run NuLink Worker:
  
```
git clone https://github.com/solotop999/script_install_nulink.git
cd script_install_nulink
chmod +x script_install_nulink.sh
./script_install_nulink.sh
```



- Check Node Status for Worker Account.
  
```
docker logs -f ursula
```

![image](https://github.com/solotop999/script_install_nulink/assets/24671262/5801474f-e532-45f5-88ad-ca26c83da01c)



<h1>Staking Process Steps<h5>
  
For information about other features of the platform, please check <a href="https://docs.nulink.org/products/stakers">here.</a>
  
After creating a worker account, please see the following guide for staking


1- Go to <a href="https://dashboard.testnet.nulink.org/">NuLink.</a> You will be greeted with a network warning. Log in to the platform with your Metamask address.

![1](https://github.com/Lorento34/NuLink-Testnet-Horus-2.0/assets/84406096/2437ff81-1e2a-4ba3-9795-7231d654c6dc)



2- You will be prompted to add the BNB Smart Chain Testnet network to your metamask and once you agree, the BNB Smart Chain Testnet network will be automatically added to your metamask. This warning will not appear if you have already added the BNB Smart Chain Testnet network to your metamask. 

![2](https://github.com/Lorento34/NuLink-Testnet-Horus-2.0/assets/84406096/92d52ead-f494-4611-b2c3-6e87e4ee71fe)



3- Click on the wallet icon on the top right and claim the test tokens. First claim the Tbnb token, second claim the Nlk token. If you encounter a problem when requesting test tokens then try other browsers

![3](https://github.com/Lorento34/NuLink-Testnet-Horus-2.0/assets/84406096/519736ab-fce9-4ba7-a288-3cb5d4315e1c)


4- After requesting the test tokens, enter the Staking section and click Approve in My Balance


![4](https://github.com/Lorento34/NuLink-Testnet-Horus-2.0/assets/84406096/5cd508f6-a9c4-4aab-82e1-45255020cf18)


5- After Approve, the button for staking will be active and you can do the staking.

![5](https://github.com/Lorento34/NuLink-Testnet-Horus-2.0/assets/84406096/7cb38f2f-a0a6-4e08-a582-f9847377b914)

6- Go to the Node Information section below and click on the Bond worker button. Paste your worker address here and click on the Bond button.

![image](https://github.com/solotop999/script_install_nulink/assets/24671262/665c9edc-b01a-41d0-9811-b1cc6e28aa55)



7- And the final. If you have a smooth node installation and staking process, you will soon have an image like below.

![image](https://github.com/solotop999/script_install_nulink/assets/24671262/c853dc7e-d324-4eb1-ae52-a58db6c39ab0)





























