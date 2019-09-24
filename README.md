# Deploy Solodev DCX on an EKS Cluster via Helm Charts
The following steps will allow you to deploy Solodev DCX to an existing EKS cluster via Helm Charts. Additional installation methods are available including <a href="https://github.com/techcto/quickstart-solodev-dcx/blob/master/pages/deploy-solodev-dcx.md">via AWS CloudFormation</a> or via <a href="https://github.com/techcto/quickstart-solodev-dcx/blob/master/pages/deploy-solodev-dcx-kcmd.md">custom kubectl commands</a>.

These instructions presume you already have installed <a href="https://helm.sh/">Helm</a>, <a href="https://kubernetes.io/">Kubernetes</a>, and the <a href="https://kubernetes.io/docs/tasks/tools/install-kubectl/">Kubernetes command-line tool</a>.

## Step 1: Subscribe on the AWS Marketplace
Solodev is a professionally managed, enterprise-class Digital Customer Experience Platform and content management system (CMS). Before launching one of our products, you'll first need to subscribe to Solodev on the <a href="https://aws.amazon.com/marketplace/pp/B07XV951M6">AWS Marketplace.</a> Click the button below to get started: 
<table>
	<tr>
		<td width="60%"><a href="https://aws.amazon.com/marketplace/pp/B07XV951M6"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/AWS_Marketplace_Logo.jpg" /></a></td>
		<td><a href="https://aws.amazon.com/marketplace/pp/B07XV951M6"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/Subscribe_Large.jpg" /></a></td>
	</tr>
</table>

## Step 2: Download and Configure setService.sh
Access and download the <a href="https://github.com/techcto/quickstart-solodev-dcx/blob/master/eks/bin/setService.sh">Solodev setService.sh script</a>. Place the shell script inside a directory you will use to access your Kubernetes cluster.

Modify lines 4-5; the values will correspond to your existing EKS cluster's name as well as its region.

<pre>
export EKSName=""
export Region="us-east-1"
</pre>

## Step 3: Create Service Account
From command line and inside the directory that has the setService.sh script, run the following to create a service account:
<pre>
initServiceAccount
</pre>

 Visit the <a href="https://aws.amazon.com/blogs/opensource/introducing-fine-grained-iam-roles-service-accounts/">"Introducing Fine-Grained IAM Roles for Service Accounts"</a> AWS blog post for further instructions on creating your serviceAccountName through alternative means.

## Step 4: Retrive Solodev Helm Charts
Run the following commands from within your Kubernetes cluster:
<pre>
helm repo add charts 'https://raw.githubusercontent.com/techcto/charts/master/'
helm repo update
helm repo list
</pre>

## Step 5: Deploy Solodev DCX on your Kubernetes Cluster
Run the following command from within your Kubernetes cluster, specifying namespace, name, appSecret, appPassword, dbPassword values, and serviceAccountName values.
<pre>
helm install --name solodev-dcx charts/solodev-dcx-aws \
                --set serviceAccountName='solodev-serviceaccount' \
                --set solodev.storage.className=gp2 \
                --set solodev.settings.appSecret=secret \
                --set solodev.settings.appPassword=password \
                --set solodev.settings.dbPassword=password
</pre>

## Step 6: Retrieve the External Endpoints of the "ui" Service
In addition to the other services deployed, Solodev DCX will deploy a "ui" service. This service will output external endpoints that you can use to access Solodev DCX. 

<table>
	<tr>
		<td><img src="https://raw.githubusercontent.com/solodev/AWS-Launch-Pad/master/pages/images/install/eks-external-endpoints.jpg" /></td>
	</tr>
</table>

## Step 7: Login to Solodev 
Visit the external endpoint retrived in step 4 to load Solodev DCX. Use the the username "solodev" and the appPassword specified during step 3 for login credentials.

<table>
	<tr>
		<td><img src="https://raw.githubusercontent.com/solodev/AWS-Launch-Pad/master/pages/images/install/login-solodev-cms-eks.jpg" /></td>
	</tr>
</table>