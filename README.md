# Deploy Solodev DCX on an EKS Cluster via Helm Charts
The following steps will allow you to deploy Solodev DCX to an existing EKS cluster via Helm Charts. Additional installation methods are available including <a href="https://github.com/techcto/quickstart-solodev-dcx/blob/master/pages/deploy-solodev-dcx.md">via AWS CloudFormation</a> or via <a href="https://github.com/techcto/quickstart-solodev-dcx/blob/master/pages/deploy-solodev-dcx-kcmd.md">custom kubectl commands</a>.

These instructions presume you already have installed <a href="https://kubernetes.io/docs/tasks/tools/install-kubectl/">kubectl</a>, <a href="https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html">aws-iam-authenticator</a>, <a href="https://stedolan.github.io/jq/">jq</a> (<a href="https://chocolatey.org/packages/jq">windows install instructions</a>), and <a href="https://github.com/helm/helm">kubernetes-helm</a>.

## Step 1: Subscribe on the AWS Marketplace
Solodev is a professionally managed, enterprise-class Digital Customer Experience Platform and content management system (CMS). Before launching one of our products, you'll first need to subscribe to Solodev on the <a href="https://aws.amazon.com/marketplace/pp/B07XV951M6">AWS Marketplace.</a> Click the button below to get started: 
<table>
	<tr>
		<td width="60%"><a href="https://aws.amazon.com/marketplace/pp/B07XV951M6"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/AWS_Marketplace_Logo.jpg" /></a></td>
		<td><a href="https://aws.amazon.com/marketplace/pp/B07XV951M6"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/Subscribe_Large.jpg" /></a></td>
	</tr>
</table>

## (Optional) Step 2: Create EKS Cluster via Command Line
If you wish to deploy Solodev DCX to an existing Kubernetes cluster, skip to Step 3.

For AWS users needing to create a new cluster, please follow the <a href="https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html">Getting Started instructions</a> to deploy a new EKS cluster with your unique cluster-spec.yaml and eksctl.

## Step 3: Download and Configure setService.sh
Access and download the <a href="https://github.com/techcto/quickstart-solodev-dcx/blob/master/eks/bin/setService.sh">Solodev setService.sh script</a>. Place the shell script inside a directory you will use to access your Kubernetes cluster.

Modify lines 4-6; the values will correspond to your existing EKS cluster's name as well as its region. This deployment assumes you will launch into the "default" namespace. Change this value if different.

<pre>
export EKSName=""
export Region="us-east-1"
export NAMESPACE="default"
</pre>

## Step 4: Create Service Account
From command line and inside the directory that has the setService.sh script, run the following to create a service account:
<pre>
./setService.sh initServiceAccount
</pre>

 Visit the <a href="https://aws.amazon.com/blogs/opensource/introducing-fine-grained-iam-roles-service-accounts/">"Introducing Fine-Grained IAM Roles for Service Accounts"</a> AWS blog post for further instructions on creating your serviceAccountName through alternative means.

## Step 5: Retrive Solodev Helm Charts
Run the following commands from within your Kubernetes cluster:
<pre>
helm repo add charts 'https://raw.githubusercontent.com/techcto/charts/master/'
helm repo update
helm repo list
</pre>

## Step 6: Deploy Solodev DCX on your Kubernetes Cluster
Run the following command from within your Kubernetes cluster, specifying namespace, name, appSecret, appPassword, dbPassword values, and serviceAccountName values.
<pre>
helm install --name solodev-dcx charts/solodev-dcx-aws \
                --set serviceAccountName='solodev-serviceaccount' \
                --set solodev.storage.className=gp2 \
                --set solodev.settings.appSecret=secret \
                --set solodev.settings.appPassword=password \
                --set solodev.settings.dbPassword=password
</pre>

## Step 7: Retrieve the External Endpoints of the "ui" Service
Run the following command to retrieve the hostname of the deployed Solodev DCX. The command will return the CNAME address related to the "ui" pod. Change the "solodev-dcx" portion to match the name of your installed deployment.

<pre>
kubectl get svc solodev-dcx-ui -o yaml | grep hostname
</pre>

## Step 8: Login to Solodev 
Visit the external endpoint retrived in step 7 to load Solodev DCX. Use the the username "solodev" and the appPassword specified during step 3 for login credentials.

<table>
	<tr>
		<td><img src="https://raw.githubusercontent.com/solodev/AWS-Launch-Pad/master/pages/images/install/login-solodev-cms-eks.jpg" /></td>
	</tr>
</table>