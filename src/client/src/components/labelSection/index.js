import React, { useState, useEffect } from 'react';
import Http from '../../util/http-common';
import LabelMilestoneButton from '../LabelMilestoneButton';
import LabelList from './LabelList';
import Button from '../Button';
import TouchLabel from './TouchLabel';
import {
  ButtonBox,
  Container,
  Header,
  ContentsContainer,
  ContentsListHeader,
} from './labelStyle';

function LabelSection() {
  const [labelList, setLabelList] = useState([]);
  const [activeNew, setActiveNew] = useState(false);
  const [rerender, setRerender] = useState(false);

  const handleNewLabel = () => setActiveNew(!activeNew);
  const handleRerender = () => setRerender(!rerender);

  useEffect(() => {
    fetch(`${Http}api/label`)
      .then((res) => res.json())
      .then((labels) => {
        setLabelList(labels);
      });
  }, [activeNew, rerender]);

  return (
    <Container>
      <Header>
        <LabelMilestoneButton page="label" left={true} />
        <ButtonBox>
          <Button handler={handleNewLabel}>new Label</Button>
        </ButtonBox>
      </Header>
      {activeNew && <TouchLabel handler={handleNewLabel}></TouchLabel>}
      {labelList.length ? (
        <ContentsContainer>
          <ContentsListHeader>{labelList.length} labels</ContentsListHeader>
          {labelList.map((label, index) => (
            <LabelList
              handleRender={handleRerender}
              label={label}
              key={index}
            />
          ))}
        </ContentsContainer>
      ) : null}
    </Container>
  );
}

export default LabelSection;
