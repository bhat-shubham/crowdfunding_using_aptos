**Student Crowdfunding Platform**

**Vision**

The **Student Crowdfunding Platform** aims to provide a decentralized way for students to raise funds for their educational expenses. Built on the Aptos blockchain, the platform allows students to create crowdfunding campaigns and receive contributions in cryptocurrency, ensuring secure and transparent transactions.

**Features**

- **Campaign Creation**: Students can create new crowdfunding campaigns by specifying their funding goals.
- **Contribution System**: Users can contribute directly to the campaigns using the Aptos Coin, and their contributions are reflected on the blockchain.
- **Automatic Campaign Management**: Campaigns automatically deactivate when the goal is met.
- **Real-time Campaign Information**: Users can view the details of the most recent campaigns, including goal amounts, raised amounts, and active status.

**Smart Contract Information**

The backend of the platform is powered by a smart contract written in the Move language and deployed on the Aptos blockchain. Key details of the contract:

**Contract Functions**

1. **Create Campaign**:
   1. Function: create\_campaign(account: &signer, goal\_amount: u64)
   1. Purpose: Initializes a new campaign for a student with a specified funding goal.
1. **View Campaign**:
   1. Function: view\_recent\_campaign(addr: address): (u64, u64, bool)
   1. Purpose: Retrieves the details of the most recent campaign, including the goal, current raised amount, and active status.
1. **Contribute**:
   1. Function: contribute(account: &signer, campaign\_owner: address, amount: u64)
   1. Purpose: Allows users to contribute Aptos Coins to the campaign of a specific student.

**Deployment**

- **Network**: Aptos
- **Contract Address**: WILL UPDATE SOON
- **LINK** : https://explorer.aptoslabs.com/txn/41912873?network=devnet
- **Transaction Hash:** WILL UPDATE SOON
- **Coin Used**: Aptos Coin (APT)


**Getting Started**

To get started with this project, follow these steps:

1. **Install Dependencies**: Run npm install to install the necessary dependencies for the React frontend.
1. **Run Frontend**: Run npm start to start the React application locally.
1. **Connect Wallet**: Ensure your Aptos-compatible wallet (like Petra Wallet) is connected to interact with the platform.

**Conclusion**

The Student Crowdfunding Platform provides a decentralized, trustless way for students to raise money for their education while allowing contributors to directly support students' educational goals with secure transactions on the blockchain.

