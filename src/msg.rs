use schemars::JsonSchema;
use serde::{Deserialize, Serialize};

use cosmwasm_std::{Binary, Decimal};
use cw721::Expiration;

use crate::{state::CollectionInfo, ContractError};
#[derive(Serialize, Deserialize, Clone, Debug, PartialEq, JsonSchema)]
pub struct InstantiateMsg {
    pub name: String,
    pub symbol: String,
    pub minter: String,
    pub collection_info: CollectionInfo<RoyaltyInfoResponse>,
}

#[derive(Serialize, Deserialize, Clone, PartialEq, JsonSchema, Debug)]
#[serde(rename_all = "snake_case")]
pub enum ExecuteMsg<T> {
    TransferNft { recipient: String, token_id: String },
    SendNft {
        contract: String,
        token_id: String,
        msg: Binary,
    },
    Approve {
        spender: String,
        token_id: String,
        expires: Option<Expiration>,
    },
    Revoke { spender: String, token_id: String },

    ApproveAll {
        operator: String,
        expires: Option<Expiration>,
    },

    RevokeAll { operator: String },

    Mint(MintMsg<T>),

    Burn { token_id: String },
}

#[derive(Serialize, Deserialize, Clone, Debug, PartialEq, JsonSchema)]
pub struct MintMsg<T> {
    pub token_id: String,
    pub owner: String,
    pub token_uri: Option<String>,
    pub extension: T,
}

#[derive(Serialize, Deserialize, Clone, Debug, PartialEq, JsonSchema)]
#[serde(rename_all = "snake_case")]
pub enum QueryMsg {
    OwnerOf {
        token_id: String,
        include_expired: Option<bool>,
    },

    Approval {
        token_id: String,
        spender: String,
        include_expired: Option<bool>,
    },

    Approvals {
        token_id: String,
        include_expired: Option<bool>,
    },

    AllOperators {
        owner: String,
        include_expired: Option<bool>,
        start_after: Option<String>,
        limit: Option<u32>,
    },
 
    NumTokens {},

    ContractInfo {},
 
    NftInfo {
        token_id: String,
    },

    AllNftInfo {
        token_id: String,
        include_expired: Option<bool>,
    },

    Tokens {
        owner: String,
        start_after: Option<String>,
        limit: Option<u32>,
    },

    AllTokens {
        start_after: Option<String>,
        limit: Option<u32>,
    },

    Minter {},

    CollectionInfo {},
}

#[derive(Serialize, Deserialize, Clone, PartialEq, JsonSchema, Debug)]
pub struct MinterResponse {
    pub minter: String,
}

#[derive(Serialize, Deserialize, Clone, Debug, PartialEq, JsonSchema)]
pub struct CollectionInfoResponse {
    pub creator: String,
    pub description: String,
    pub image: String,
    pub external_link: Option<String>,
    pub royalty_info: Option<RoyaltyInfoResponse>,
}

#[derive(Serialize, Deserialize, Clone, Debug, PartialEq, JsonSchema)]
pub struct RoyaltyInfoResponse {
    pub payment_address: String,
    pub share: Decimal,
}

impl RoyaltyInfoResponse {
    pub fn share_validate(&self) -> Result<Decimal, ContractError> {
        if self.share > Decimal::percent(20) {
            return Err(ContractError::InvalidRoyalities {});
        }

        Ok(self.share)
    }
}