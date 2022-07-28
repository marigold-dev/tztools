import axios from "axios";
import { verify } from "crypto";
import React, { useState } from "react";

const Input = (props: {
  value: string;
  placeholder: string;
  onChange?: (value: string) => void;
}) => {
  return (
    <input
      id="result"
      value={props.value}
      onChange={(i) => props.onChange && props.onChange(i.target.value)}
      className="mt-5 block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
      placeholder={props.placeholder}
    ></input>
  );
};

const Button = (props: {
  onClick: () => void;
  enableWhen?: boolean;
  width: string;
  children: string;
}) => {
  return (
    <button
      type="submit"
      onClick={props.onClick}
      style={{ width: props.width }}
      disabled={!props.enableWhen}
      className="disabled:bg-gray-50 disabled:text-slate-500 disabled:border-slate-200 border border-gray-300 inline-flex my-3 items-center py-2.5 px-4 text-xs font-medium text-center justify-center text-white bg-blue-700 rounded-lg focus:ring-4 focus:ring-blue-200 dark:focus:ring-blue-900 hover:bg-blue-800"
    >
      {props.children}
    </button>
  );
};

function EdDSA() {
  const [privateKey, setPrivateKey] = useState("");
  const [publicKey, setPublicKey] = useState("");
  const [message, setMessage] = useState("");
  const [signature, setSignature] = useState("");
  const [verifyResult, setVerifyResult] = useState("");

  const onVerify = () => {
    let url = new URL(`${process.env["REACT_APP_API"]}/ed25519/verify`);
    url.searchParams.append("pk", publicKey);
    url.searchParams.append("msg", message);
    url.searchParams.append("signature", signature);
    axios
      .get<string>(url.toString())
      .then((res) => {
        if (res.data) {
          setVerifyResult("Verified");
        } else {
          setVerifyResult("Not verified");
        }
      })
      .catch((error) => {
        console.log(error);
        setVerifyResult(error.message);
      });
  };

  const onPrivateToPublic = () => {
    let url = new URL(`${process.env["REACT_APP_API"]}/ed25519/public`);
    url.searchParams.append("sk", privateKey);
    axios
      .get<string>(url.toString())
      .then((res) => {
        setPublicKey(res.data);
      })
      .catch((error) => {
        console.log(error);
        setVerifyResult(error.message);
      });
  };

  const onSign = () => {
    let url = new URL(`${process.env["REACT_APP_API"]}/ed25519/sign`);
    url.searchParams.append("sk", privateKey);
    url.searchParams.append("msg", message);
    axios
      .get<string>(url.toString())
      .then((res) => {
        setSignature(res.data);
      })
      .catch((error) => {
        console.log(error);
        setVerifyResult(error.message);
      });
  };

  return (
    <div className="flex justify-center w-screen dark:bg-slate-500">
      <div className="flex bg-white dark:bg-slate-800 rounded-lg px-6 py-8 ring-1 ring-slate-900/5 shadow-xl w-11/12 h-5/6 mt-8 flex-col">
        <h1 className="text-slate-900 dark:text-white mt-0 text-3xl font-medium tracking-tight">
          EdDSA (ED25519)
        </h1>

        <p className="text-slate-500 dark:text-slate-400 mt-2 text-lg">
          Operatins with Ed25519 signature algorithm (EdDSA over the Curve25519
          in Edwards form)
        </p>

        <Input
          value={privateKey}
          onChange={setPrivateKey}
          placeholder="Private Key"
        />
        <Input
          value={publicKey}
          onChange={setPublicKey}
          placeholder="Public Key"
        />
        <Input value={message} onChange={setMessage} placeholder="Message" />
        <Input
          value={signature}
          onChange={setSignature}
          placeholder="Signature"
        />

        <div className="flex justify-between">
          <Button
            width="30%"
            onClick={() => onPrivateToPublic()}
            enableWhen={privateKey ? privateKey.length > 0 : false}
          >
            Private to Public Key
          </Button>
          <Button
            width="30%"
            onClick={onSign}
            enableWhen={privateKey?.length > 0 && message?.length > 0}
          >
            Sign
          </Button>
          <Button
            width="30%"
            onClick={onVerify}
            enableWhen={
              publicKey?.length > 0 &&
              message?.length > 0 &&
              signature?.length > 0
            }
          >
            Verify
          </Button>
        </div>
        <p className="text-slate-500 dark:text-slate-400 mt-2 text-lg text-center">
          {" "}
          {verifyResult}
        </p>
      </div>
    </div>
  );
}

export default EdDSA;
